import '../../export.dart';

class LecturerHomeScreen extends StatelessWidget {
  final Map<String, String> arguments;

  const LecturerHomeScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  ('Logout'),
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                content: Text(
                  'Are you sure want to logout?',
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
                      storage.deleteAllData().then((_) {
                        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                      });
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
                                'Logout Success',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Logout Now',
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
        child: const Icon(Icons.logout),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-course');
            },
            icon: const Icon(Icons.add),
          )
        ],
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CheckLoginBloc, CheckLoginState>(
                    builder: (context, state) {
                      if (state is CheckLoginSuccess) {
                        return Text(
                          "Hello, ${state.data.name.toUpperCase()}",
                          style: blackTextStyle.copyWith(fontSize: 22, fontWeight: bold),
                        );
                      } else if (state is CheckLoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginSuccess) {
                              return Text(
                                "Hello, ${state.user.data!.name!.toUpperCase()}",
                                style: blackTextStyle.copyWith(fontSize: 22, fontWeight: bold),
                              );
                            } else if (state is LoginLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is LoginError) {
                              return Text(
                                state.message,
                                style: blackTextStyle.copyWith(fontSize: 22, fontWeight: bold),
                              );
                            } else {
                              return const Text('undefined');
                            }
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  BlocBuilder<CheckLoginBloc, CheckLoginState>(
                    builder: (context, state) {
                      if (state is CheckLoginSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Daftar kursus : ", style: blackTextStyle.copyWith(fontSize: 20)),
                            const SizedBox(height: 16),
                            BlocBuilder<GetCourseByIdBloc, GetCourseByIdState>(
                              bloc: context.read<GetCourseByIdBloc>()..add(CourseByIdEvent(id: state.data.idUser)),
                              builder: (context, state) {
                                if (state is GetCourseByIdLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is GetCourseByIdSuccess) {
                                  var dataLength = state.course.data!.length;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dataLength,
                                    itemBuilder: (context, index) {
                                      var course = state.course.data![index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/lecturer-detail',
                                            arguments: {
                                              "id": course.id,
                                              "title": course.title,
                                              "image": course.image,
                                              "description": course.description,
                                            },
                                          );
                                        },
                                        child: ListTile(
                                          title: Text(
                                            course.title.toString(),
                                            style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            course.description.toString(),
                                            style: greyTextStyle.copyWith(fontWeight: regular),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              //Show Dialog Delete Course
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      ('Delete Course'),
                                                      style: blackTextStyle.copyWith(
                                                        fontSize: 18,
                                                        fontWeight: bold,
                                                      ),
                                                    ),
                                                    content: Text(
                                                      'Are you sure want to delete ${course.title}?',
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
                                                          context.read<DeleteVideoBloc>().add(DeleteVideoFromCourseEvent(id: course.id.toString()));
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
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text('kamu belum memiliki kursus'),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      } else {
                        return BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginSuccess) {
                              print(state.user.data!.id);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Daftar kursus : ", style: blackTextStyle.copyWith(fontSize: 20)),
                                  const SizedBox(height: 16),
                                  BlocBuilder<GetCourseByIdBloc, GetCourseByIdState>(
                                    bloc: context.read<GetCourseByIdBloc>()..add(CourseByIdEvent(id: state.user.data!.id.toString())),
                                    builder: (context, state) {
                                      if (state is GetCourseByIdLoading) {
                                        return const CircularProgressIndicator();
                                      } else if (state is GetCourseByIdSuccess) {
                                        var dataLength = state.course.data!.length;
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: dataLength,
                                          itemBuilder: (context, index) {
                                            var course = state.course.data![index];
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/lecturer-detail',
                                                  arguments: {
                                                    "id": course.id,
                                                    "title": course.title,
                                                    "image": course.image,
                                                    "description": course.description,
                                                  },
                                                );
                                              },
                                              child: ListTile(
                                                title: Text(course.title.toString(), style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold)),
                                                subtitle: Text(
                                                  course.description.toString(),
                                                  style: greyTextStyle.copyWith(fontWeight: regular),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    //Show Dialog Delete Course
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            ('Delete Course'),
                                                            style: blackTextStyle.copyWith(
                                                              fontSize: 18,
                                                              fontWeight: bold,
                                                            ),
                                                          ),
                                                          content: Text(
                                                            'Are you sure want to delete ${course.title}?',
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
                                                                BlocListener<DeleteCourseBloc, DeleteCourseState>(
                                                                  bloc: context.read<DeleteCourseBloc>()..add(DeleteCourseByIdEvent(id: course.id.toString())),
                                                                  listener: (context, state) {
                                                                    // TODO: implement listener
                                                                    if (state is DeleteCourseSuccess) {
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
                                                                                state.message,
                                                                                style: whiteTextStyle.copyWith(
                                                                                  fontSize: 14,
                                                                                  fontWeight: bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (state is DeleteCourseError) {
                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                        SnackBar(
                                                                          duration: const Duration(seconds: 3),
                                                                          behavior: SnackBarBehavior.floating,
                                                                          elevation: 0,
                                                                          backgroundColor: kRedColor,
                                                                          content: Row(
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.beenhere_rounded,
                                                                                color: Colors.white,
                                                                              ),
                                                                              const SizedBox(width: 12),
                                                                              Text(
                                                                                state.message,
                                                                                style: whiteTextStyle.copyWith(
                                                                                  fontSize: 14,
                                                                                  fontWeight: bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                );
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
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return const Text('kamu belum memiliki kursus');
                                      }
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return const Text('kamu belum memiliki kursus'); //
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
        ],
      ),
    );
  }
}
