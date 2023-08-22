import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:online_learning_app/data/models/app/category_model.dart';
import 'package:online_learning_app/export.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  File? imageSelected;
  String? _base64;
  final TextEditingController categoryId = TextEditingController();
  final TextEditingController memberId = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController image = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? selectedCategory;
  late int selectedCategoryId;
  late int categoryValue;
  String? imagePath;
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    void addNewCourse() {
      // Nonaktifkan tombol
      setState(() {
        isButtonDisabled = true;
      });

      // Lakukan tindakan yang diperlukan
      if (_formKey.currentState!.validate()) {
        // If the form is valid, display a snackbar. In the real world,
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: kLoadingColor,
            content: Row(
              children: [
                Text('Loading'),
                SizedBox(width: 12),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              ],
            ),
          ),
        );
        //Store the data
        print("CATEGORY ID : $selectedCategory");
        print("TITLE : ${title.text}");
        print("DESCRIPTION : ${desc.text}");
        print("IMAGE $imagePath");
        context.read<AddCourseBloc>().add(
              AddNewCourseEvent(
                categoryId: selectedCategory,
                desc: desc.text,
                image: _base64.toString(),
                title: title.text,
              ),
            );
      }

      // Aktifkan kembali tombol setelah selesai
      setState(() {
        isButtonDisabled = false;
      });
    }

    Future pickImageFromGallery() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      setState(() {
        imagePath = image.path;
      });
      File path = File(image.path);
      String format = image.path.split('.').last;
      final base64String = base64Encode(path.readAsBytesSync());
      _base64 = 'data:image/$format;base64,$base64String';
      print(_base64);
    }

    Future removeImage() async {
      setState(() {
        imagePath = null;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: title,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Title is required";
                      }
                      return null;
                    },
                    // controller: nameC,
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
                      hintText: 'Judul Kursus',
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
                        Icons.abc,
                        size: 20,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                      bloc: CategoryBloc()..add(const GetCategoryEvent()),
                      builder: (context, state) {
                        if (state is CategorySuccess) {
                          final List<Data>? categories = state.categories.data;
                          print(categories);
                          return DropdownButtonHideUnderline(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    const Icon(
                                      Icons.account_circle_outlined,
                                      size: 20,
                                      color: kGreyColor,
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Kategori',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          color: kGreyColor,
                                          fontWeight: regular,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: categories!.isNotEmpty
                                    ? categories
                                        .map<DropdownMenuItem<int>>(
                                          (item) => DropdownMenuItem<int>(
                                            value: item.id,
                                            child: Text(
                                              item.name.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: regular,
                                                color: kBlackColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList()
                                    : [],
                                value: selectedCategory,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value as int?;
                                    categoryValue = value as int;
                                  });
                                },
                                //
                                icon: const Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                iconEnabledColor: kPrimaryColor,
                                iconDisabledColor: kGreyColor,
                                buttonHeight: 60,
                                buttonWidth: double.infinity,
                                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: kGreyColor,
                                  ),
                                  color: Colors.transparent,
                                ),
                                buttonElevation: 0,
                                itemHeight: 50,
                                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 290,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  border: Border.all(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                dropdownElevation: 0,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                              ),
                            ),
                          );
                        } else if (state is CategoryError) {
                          return Text(state.message);
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: desc,
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Deskripsi is required";
                      }
                      return null;
                    },
                    // controller: widget.regisEmailC,
                    autocorrect: false,
                    style: blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
                    cursorColor: kBlackColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      hintText: 'Deskripsi',
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
                        Icons.description,
                        size: 20,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       imagePath != null
                  //           ? Column(
                  //               crossAxisAlignment: CrossAxisAlignment.end,
                  //               children: [
                  //                 IconButton(onPressed: removeImage, icon: const Icon(Icons.delete)),
                  //                 SizedBox(
                  //                   width: double.infinity,
                  //                   child: Image.file(
                  //                     File(imagePath!),
                  //                     width: 500,
                  //                     height: 200,
                  //                   ),
                  //                 ),
                  //               ],
                  //             )
                  //           : const Text('ukuran 200x200'),
                  //       const SizedBox(height: 12),
                  //       ElevatedButton(
                  //         onPressed: pickImageFromGallery,
                  //         child: const Text('Pilih gambar'),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  BlocConsumer<AddCourseBloc, AddCourseState>(
                    listener: (context, state) {
                      if (state is AddCourseSuccess) {
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
                                  'Add Course succesfull!',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is AddCourseError) {
                        print(state.message);
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
                        onPressed: addNewCourse,
                        title: 'Add Course Now',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semibold,
                        ),
                        height: 55,
                        backgroundColor: isButtonDisabled ? kGreyColor : kPrimaryColor,
                        width: double.infinity,
                        borderRadius: 20,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
