import 'package:online_learning_app/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required Map<String, String> arguments});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<CheckLoginBloc, CheckLoginState>(
                    builder: (context, state) {
                      if (state is CheckLoginSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo,',
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.data.name.toUpperCase(),
                              style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Halo,',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: regular,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state.user.data!.name.toString().toUpperCase(),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ],
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
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Kursus Kamu',
                    style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCourseScreen()));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      'Lihat Semua',
                      style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<CheckLoginBloc, CheckLoginState>(
                builder: (context, state) {
                  if (state is CheckLoginSuccess) {
                    return BlocBuilder<GetUserJoinedCourseBloc, GetUserJoinedCourseState>(
                      bloc: context.read<GetUserJoinedCourseBloc>()..add(UserJoinedCourseEvent(userId: state.data.idUser.toString())),
                      builder: (context, state) {
                        if (state is GetUserJoinedCourseSuccess) {
                          var dataLength = state.joinedCourse.data!.course!.length;
                          if (state.joinedCourse.data!.course!.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: dataLength,
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
                                      color: kTileColor,
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
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      course.title!,
                                                      style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                                                    ),
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
                          } else {
                            return Text(
                              'data kosong',
                              style: redTextStyle.copyWith(fontSize: 50),
                            );
                          }
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
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.joinedCourse.data!.course!.length,
                                  itemBuilder: (context, index) {
                                    var course = state.joinedCourse.data!.course![index];
                                    var lecturer = state.joinedCourse.data!.lecturer![index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true).pushNamed(
                                          "/detail-course",
                                          arguments: {
                                            "id_course": course.id.toString(),
                                            "title": course.title,
                                            "category_name": course.categoryName,
                                            "description": course.description,
                                            "lecturer_name": lecturer.name,
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 16),
                                        child: Card(
                                          elevation: 0,
                                          color: kTileColor,
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
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          course.title!,
                                                          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                                                        ),
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
