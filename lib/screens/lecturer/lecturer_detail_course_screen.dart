import 'package:online_learning_app/bloc/course/video/get_video_by_course_id_and_author_id/get_video_by_course_id_and_author_id_bloc.dart';
// import '../../data/models/course/course_model.dart';
import 'package:online_learning_app/export.dart';

class LecturerDetailCourse extends StatelessWidget {
  final dynamic args;
  const LecturerDetailCourse({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    // final course = ModalRoute.of(context)!.settings.arguments as Data;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  size: 40,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/add-video',
                        arguments: {
                          "id": args["id"],
                          "title": args["title"],
                        },
                      );
                    },
                    title: "Tambah Video",
                    style: whiteTextStyle.copyWith(fontSize: 10, fontWeight: semibold),
                    borderRadius: 20,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                args["title"],
                style: orangeTextStyle.copyWith(fontSize: 25, fontWeight: bold),
              ),
              const SizedBox(height: 18),
              Text(
                "Deskripsi : ",
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
              const SizedBox(height: 12),
              Text(
                args["description"],
                style: blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
              const SizedBox(height: 16),
              Text(
                "Materi Video: ",
                style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
              const SizedBox(height: 24),
              BlocBuilder<GetVideoByCourseIdAndAuthorIdBloc, GetVideoByCourseIdAndAuthorIdState>(
                bloc: context.read<GetVideoByCourseIdAndAuthorIdBloc>()..add(VideoByCourseIdAndAuthorIdEvent(courseId: args['id'].toString())),
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
                          var data = state.video.data![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              tileColor: kTileColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              leading: Text(
                                "${index + 1}",
                                style: whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: regular,
                                ),
                              ),
                              title: Text(
                                data.title!,
                                style: whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: regular,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: kRedColor,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          ('Delete Video'),
                                          style: blackTextStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: bold,
                                          ),
                                        ),
                                        content: Text(
                                          'Are you sure want to delete ${data.title}?',
                                          style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: regular,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: blackTextStyle.copyWith(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.read<DeleteVideoBloc>().add(DeleteVideoFromCourseEvent(id: data.id.toString()));
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(seconds: 3),
                                                  behavior: SnackBarBehavior.floating,
                                                  elevation: 0,
                                                  backgroundColor: kGreenColor,
                                                  content: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.beenhere_rounded,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        "Delete Video Success",
                                                        style: whiteTextStyle.copyWith(
                                                          fontSize: 14,
                                                          fontWeight: bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Delete Now',
                                              style: blackTextStyle.copyWith(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Belum ada video',
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
        ),
      ),
    );
  }
}
