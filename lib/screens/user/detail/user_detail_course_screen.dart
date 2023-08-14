import 'dart:developer';

import 'package:online_learning_app/data/models/course/joined_course_model.dart';
import 'package:online_learning_app/export.dart';
import '../../../bloc/course/video/get_video_by_course_id_and_author_id/get_video_by_course_id_and_author_id_bloc.dart';

class DetailCourseScreen extends StatelessWidget {
  final dynamic args;
  const DetailCourseScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // Course course = arguments['course'] as Course;
    // Lecturer lecturer = arguments['lecturer'] as Lecturer;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_left,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 175,
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kPrimaryColor,
                          Colors.deepOrange,
                          kBackgroundColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ), // Adds a gradient background and rounded corners to the container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  args["title"],
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 25,
                                    fontWeight: bold,
                                  ),
                                ), // Adds a title to the card
                                const Spacer(),
                                Stack(
                                  children: List.generate(
                                    2,
                                    (index) => Container(
                                      margin: EdgeInsets.only(left: (15 * index).toDouble()),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white54),
                                    ),
                                  ),
                                ) // Adds a stack of two circular containers to the right of the title
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'by ${args["lecturer_name"]}',
                              style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
                            ) // Adds a subtitle to the card
                          ],
                        ),
                        Text(
                          args["category_name"],
                          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                        ) // Adds a price to the bottom of the card
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Deskripsi : ',
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    args["description"],
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Materi Video: ',
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<GetVideoByCourseIdAndAuthorIdBloc, GetVideoByCourseIdAndAuthorIdState>(
                    bloc: context.read<GetVideoByCourseIdAndAuthorIdBloc>()..add(VideoByCourseIdAndAuthorIdEvent(courseId: args["id_course"].toString())),
                    builder: (context, state) {
                      if (state is GetVideoByCourseIdAndAuthorIdLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetVideoByCourseIdAndAuthorIdError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is GetVideoByCourseIdAndAuthorIdSuccess) {
                        if (state.video.data != null && state.video.data!.isNotEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.video.data!.length,
                            itemBuilder: (context, index) {
                              var video = state.video.data![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true).pushNamed(
                                    "/detail-video",
                                    arguments: {
                                      "id_course": video.courseId.toString(),
                                      "id_video": video.id.toString(),
                                      "url_video": video.video,
                                      "title": video.title,
                                      "materi": "${index + 1}",
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                                    tileColor: kTileColor.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    leading: Text(
                                      "${index + 1}",
                                      style: whiteTextStyle.copyWith(),
                                    ),
                                    title: Text(
                                      video.title!,
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: regular,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Tidak ada video',
                              style: redTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                            ),
                          );
                        }
                      } else {
                        return const Text('error');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
