import 'package:flutter/material.dart';
import 'package:online_learning_app/bloc/auth/add_lecturer/add_lecturer_bloc.dart';
import 'package:online_learning_app/export.dart';

class AddLecturerScreen extends StatefulWidget {
  const AddLecturerScreen({super.key});

  @override
  State<AddLecturerScreen> createState() => _AddLecturerScreenState();
}

class _AddLecturerScreenState extends State<AddLecturerScreen> {
  bool _obscureText = true;
  TextEditingController nameC = TextEditingController();
  TextEditingController regisPasswordC = TextEditingController();
  TextEditingController regisEmailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> jk = [
    'Laki-Laki',
    'Perempuan',
  ];
  String? selectedJk;
  String jkValue = '';

  @override
  Widget build(BuildContext context) {
    void showPassword() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Tambah Lecturer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an Account!',
                  style: orangeTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Start your journey with us and discover a world of\nendless possibilities.',
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: light,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Nama Lengkap is required";
                    }
                    return null;
                  },
                  controller: nameC,
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
                    hintText: 'Nama Lengkap',
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
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Email is required";
                    } else if (!val.toString().contains('@')) {
                      return 'Enter valid Email';
                    }
                    return null;
                  },
                  controller: regisEmailC,
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
                    hintText: 'Email',
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
                      size: 20,
                      color: kGreyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Password is required";
                    } else if (val.length <= 6) {
                      return "Please enter a password at least 6 characters!";
                    }
                    return null;
                  },
                  controller: regisPasswordC,
                  obscureText: _obscureText,
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
                    hintText: 'Password',
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
                      Icons.key,
                      size: 20,
                      color: kGreyColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: showPassword,
                      icon: _obscureText == true
                          ? const Icon(
                              Icons.visibility_off,
                              size: 20,
                            )
                          : const Icon(Icons.visibility, size: 20),
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
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
                                'Register succesful!',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is RegisterError) {
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
                      onPressed: () {
                        (state is RegisterLoading)
                            ? null
                            : context.read<AddLecturerBloc>().add(
                                  AddNewLecturerEvent(
                                    email: regisEmailC.text,
                                    password: regisPasswordC.text,
                                    fullName: nameC.text,
                                    userName: nameC.text,
                                    dateBirth: '2000-10-10',
                                  ),
                                );
                      },
                      title: 'Register Now',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semibold,
                      ),
                      height: 55,
                      backgroundColor: (state is RegisterLoading) ? kGreyColor : kPrimaryColor,
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
    );
  }
}
