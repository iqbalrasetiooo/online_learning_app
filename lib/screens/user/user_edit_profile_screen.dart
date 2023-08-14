import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_learning_app/bloc/user/update_user/update_user_bloc.dart';
import 'package:online_learning_app/data/models/app/user_model.dart';
import 'package:online_learning_app/export.dart';

import '../../constant/storage_services.dart';
import '../../theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController bio = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? selectedGender;
  String? genderValue;
  String? _base64;
  String? imagePath;

  List<String> gender = [
    'Laki-Laki',
    'Perempuan',
  ];
  Future removeImage() async {
    setState(() {
      imagePath = null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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

  Future<UserModelStorage> readDataUser() async {
    String? user = await storage.readData('user');
    UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
    return appUserModel;
  }

  late UserModelStorage appUserModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Edit Data',
                    style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        imagePath != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(onPressed: removeImage, icon: const Icon(Icons.delete)),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Image.file(
                                      File(imagePath!),
                                      width: 300,
                                      height: 200,
                                    ),
                                  ),
                                ],
                              )
                            : const Text('Photo Profil'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: pickImageFromGallery,
                          child: const Text('Pilih gambar'),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<UserModelStorage>(
                    future: readDataUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        UserModelStorage appUserModel = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Nama Lengkap',
                              style: blackTextStyle.copyWith(fontWeight: semibold),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: appUserModel.name,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
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
                                hintText: 'Nama Lengkap..',
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
                                  Icons.mail_outline,
                                  color: kGreyColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }
                    },
                  ),
                  Text(
                    'Username',
                    style: blackTextStyle.copyWith(fontWeight: semibold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
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
                      hintText: 'Username',
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
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Jenis Kelamin',
                    style: blackTextStyle.copyWith(fontWeight: semibold),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: DropdownButtonHideUnderline(
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
                                  'Jenis Kelamin',
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
                          items: gender.isNotEmpty
                              ? gender.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList()
                              : [],
                          value: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value as String?;
                              genderValue = value;
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tanggal Lahir',
                    style: blackTextStyle.copyWith(fontWeight: semibold),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("${selectedDate.toLocal()}".split(' ')[0]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Pilih'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bio',
                    style: blackTextStyle.copyWith(fontWeight: semibold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    // initialValue: appUserModel.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
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
                      hintText: 'Bio',
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
                        color: kGreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<UpdateUserBloc, UpdateUserState>(
                    bloc: context.read<UpdateUserBloc>()
                      ..add(
                        UpdateUser(
                          selectedGender.toString(),
                          selectedDate.toString(),
                          bio.text,
                          _base64.toString(),
                          fullName.text,
                          userName.text,
                          id: appUserModel.idUser,
                        ),
                      ),
                    builder: (context, state) {
                      return CustomButton(
                        borderRadius: 20,
                        onPressed: () {},
                        title: 'Update Data',
                        height: 50,
                        style: whiteTextStyle.copyWith(fontWeight: bold),
                        backgroundColor: kPrimaryColor,
                        width: double.infinity,
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
