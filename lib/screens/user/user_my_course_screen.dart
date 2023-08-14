import 'package:online_learning_app/export.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Kursus Saya',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semibold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<CheckLoginBloc, CheckLoginState>(
                builder: (context, state) {
                  if (state is CheckLoginSuccess) {
                    return BlocBuilder<GetUserJoinedCourseBloc, GetUserJoinedCourseState>(
                      bloc: context.read<GetUserJoinedCourseBloc>()..add(UserJoinedCourseEvent(userId: state.data.idUser.toString())),
                      builder: (context, state) {
                        if (state is GetUserJoinedCourseSuccess) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: state.joinedCourse.data!.course!.length,
                            itemBuilder: (context, index) {
                              var course = state.joinedCourse.data!.course![index];
                              var lecturer = state.joinedCourse.data!.lecturer![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true).pushNamed("/detail-course", arguments: {
                                    "id_course": course.id.toString(),
                                    "title": course.title,
                                    "category_name": course.categoryName,
                                    "description": course.description,
                                    "lecturer_name": lecturer.name,
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Card(
                                    elevation: 0,
                                    color: const Color.fromRGBO(64, 75, 96, .9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/logo.png",
                                                height: 75,
                                                width: 75,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(width: 20),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      course.title!,
                                                      style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                                                    ),
                                                    // Add some spacing between the title and the subtitle
                                                    Container(height: 6),
                                                    Text(
                                                      "oleh : ${lecturer.name!}",
                                                      style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                                                    ),
                                                    Container(height: 16),
                                                    Text(
                                                      "${course.categoryName}",
                                                      style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is GetUserJoinedCourseError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: redTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: regular,
                              ),
                            ),
                          );
                        } else if (state is GetUserJoinedCourseLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Text('');
                        }
                      },
                    );
                  } else {
                    return BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoginSuccess) {
                          return BlocBuilder<GetUserJoinedCourseBloc, GetUserJoinedCourseState>(
                            bloc: context.read<GetUserJoinedCourseBloc>()..add(UserJoinedCourseEvent(userId: state.user.data!.id.toString())),
                            builder: (context, state) {
                              if (state is GetUserJoinedCourseSuccess) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.joinedCourse.data!.course!.length,
                                  itemBuilder: (context, index) {
                                    var course = state.joinedCourse.data!.course![index];
                                    var lecturer = state.joinedCourse.data!.lecturer![index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true).pushNamed("/detail-course", arguments: {
                                          "id_course": course.id.toString(),
                                          "title": course.title,
                                          "category_name": course.categoryName,
                                          "description": course.description,
                                          "lecturer_name": lecturer.name,
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 16),
                                        child: Card(
                                          elevation: 0,
                                          color: const Color.fromRGBO(64, 75, 96, .9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/logo.png",
                                                      height: 75,
                                                      width: 75,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Container(width: 20),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            course.title!,
                                                            style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                                                          ),
                                                          // Add some spacing between the title and the subtitle
                                                          Container(height: 6),
                                                          Text(
                                                            "oleh : ${lecturer.name!}",
                                                            style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                                                          ),
                                                          Container(height: 16),
                                                          Text(
                                                            "${course.categoryName}",
                                                            style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is GetUserJoinedCourseError) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: redTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: regular,
                                    ),
                                  ),
                                );
                              } else if (state is GetUserJoinedCourseLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return const Text('');
                              }
                            },
                          );
                        } else if (state is LoginError) {
                          return Center(
                            child: Text(
                              state.message.toString(),
                              style: redTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                              ),
                            ),
                          );
                        } else {
                          return const Text('error');
                        }
                      },
                    );
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
