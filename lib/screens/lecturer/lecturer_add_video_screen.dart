import 'package:online_learning_app/data/models/app/user_model.dart';
import 'package:online_learning_app/export.dart';
import '../../bloc/course/video/add_video/add_video_bloc.dart';
import '../../data/models/course/course_model.dart';

class LecturerAddVideoScreen extends StatelessWidget {
  final dynamic args;
  const LecturerAddVideoScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    TextEditingController videoTitleC = TextEditingController();
    TextEditingController videourlC = TextEditingController();
    // final course = ModalRoute.of(context)!.settings.arguments as Data;
    Future storeData() async {
      String? user = await storage.readData('user');
      UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
      context.read<AddVideoBloc>().add(
            AddVideoCourseEvent(
              title: videoTitleC.text,
              videoUrl: videourlC.text,
              authorId: appUserModel.idUser,
              courseId: args["id"].toString(),
            ),
          );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SafeArea(
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
              Text(
                'Tambah Video Untuk Kursus :',
                style: greyTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                '${args["title"]}',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                controller: videoTitleC,
                autocorrect: false,
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  hintText: 'judul video',
                  hintStyle: greyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: kGreyColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.abc_outlined,
                    color: kGreyColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                controller: videourlC,
                autocorrect: false,
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  hintText: 'input youtube url',
                  hintStyle: greyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: kGreyColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.video_file_rounded,
                    color: kGreyColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              BlocConsumer<AddVideoBloc, AddVideoState>(
                listener: (context, state) {
                  if (state is AddVideoSuccess) {
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
                              "Add Video Success",
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
                  } else if (state is AddVideoError) {
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
                    const Center(child: CircularProgressIndicator());
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    borderRadius: 20,
                    height: 50,
                    title: "Tambah Video",
                    backgroundColor: kPrimaryColor,
                    width: double.infinity,
                    style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semibold),
                    onPressed: () {
                      storeData();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
