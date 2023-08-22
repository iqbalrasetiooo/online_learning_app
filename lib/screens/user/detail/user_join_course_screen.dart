import 'package:online_learning_app/bloc/course/join_course/join_bloc.dart';
import 'package:online_learning_app/data/models/course/course_model.dart';

import '../../../export.dart';

class JoinCourseScreen extends StatelessWidget {
  // final DestinationModel destination;

  const JoinCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.timestamp();

    final course = ModalRoute.of(context)!.settings.arguments as Data;
    Widget backgroundImage() {
      return Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
            fit: BoxFit.cover,
            image: const NetworkImage(
                'https://images.unsplash.com/photo-1616587894289-86480e533129?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHZpZGVvJTIwbGVhcm5pbmd8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'),
          ),
        ),
      );
    }

    Widget customShadow() {
      return Container(
        height: 214,
        margin: const EdgeInsets.only(top: 236),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kWhiteColor.withOpacity(0),
              Colors.black.withOpacity(0.95),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NOTE: Icon Back
            const SizedBox(height: 16),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: kWhiteColor,
              ),
            ),
            // NOTE: Icon Back
            Container(
              margin: const EdgeInsets.only(top: 256),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title.toString(),
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 4),
                    // child: Image.asset(
                    //   'assets/icon_star.png',
                    // ),
                  ),
                ],
              ),
            ),

            // NOTE: Description
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Deskripsi',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    course.description.toString(),
                    style: greyTextStyle.copyWith(
                      fontWeight: regular,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  const Row(
                    children: [
                      // InterestItem(title: 'Kids Park'),
                      // InterestItem(title: 'City Museum'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      // InterestItem(title: 'Honor Bridge'),
                      // InterestItem(title: 'Central Mall'),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 70,
                  bottom: 30,
                ),
                child: BlocConsumer<JoinBloc, JoinState>(
                  listener: (context, state) {
                    if (state is JoinSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 5),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: kGreenColor,
                          content: Row(
                            children: [
                              const Icon(Icons.beenhere_rounded, color: Colors.white),
                              const SizedBox(width: 12),
                              Text(
                                'Join succesfully!',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is JoinError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          backgroundColor: kRedColor,
                          content: Row(
                            children: [
                              const Icon(Icons.beenhere_rounded, color: Colors.white),
                              const SizedBox(width: 12),
                              Text(state.message),
                            ],
                          ),
                        ),
                      );
                    } else {
                      const CircularProgressIndicator();
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      title: 'Join Kelas',
                      height: 50,
                      width: double.infinity,
                      borderRadius: 20,
                      backgroundColor: kPrimaryColor,
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                      onPressed: () {
                        print('test button');
                        print(now);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                ('Join Kelas'),
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: bold,
                                ),
                              ),
                              content: Text(
                                'Kamu yakin ingin join kelas ${course.title}?',
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
                                    'Batal',
                                    style: blackTextStyle.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<JoinBloc>().add(
                                          JoinCourseEvent(
                                            courseId: course.id.toString(),
                                            joinedAt: now.toString(),
                                          ),
                                        );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Join Sekarang',
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundImage(),
              customShadow(),
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
