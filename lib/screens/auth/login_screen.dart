import 'package:online_learning_app/export.dart';

class LoginScreen extends StatefulWidget {
  TextEditingController loginEmailC = TextEditingController();
  TextEditingController loginPasswordC = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showPassword() {
    setState(() {
      widget._obscureText = !widget._obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: SingleChildScrollView(
        child: Form(
          key: widget._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Welcome Back',
                    style: orangeTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/hi.png',
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
              //Subtitle
              const SizedBox(height: 10),
              Text(
                'We happy to see you again. Please enter the form\nto continue to your account.',
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: light,
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                // validator: (val) {
                //   widget.validated = false;
                //   if (val == null || val.isEmpty) {
                //     return "Email or username is required";
                //   } else {
                //     widget.validated = true;
                //   }
                //   return null;
                // },
                controller: widget.loginEmailC,
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
                  hintText: 'Email or username',
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
              TextFormField(
                controller: widget.loginPasswordC,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (val) {
                //   if (val == null || val.isEmpty) {
                //     return "Password is required";
                //   } else if (val.length <= 6) {
                //     return "Please enter a password at least 6 characters!";
                //   }
                //   return null;
                // },
                scrollPadding: const EdgeInsets.only(bottom: 165.0),
                autocorrect: false,
                obscureText: widget._obscureText,
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
                cursorColor: kGreyColor,
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
                    color: kGreyColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _showPassword,
                    icon: widget._obscureText == true ? const Icon(Icons.visibility_off, size: 20) : const Icon(Icons.visibility, size: 20),
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    var user = state.user.data;
                    storage.saveDataUser(
                      idUser: "${user!.id}",
                      fullname: "${user.name}",
                      role: "${user.role}",
                      email: "${user.email}",
                    );
                    if (state.user.data!.role == 'ADMIN') {
                      Navigator.pushNamedAndRemoveUntil(context, '/admin-main', (route) => false);
                    } else if (state.user.data!.role == 'LECTURER') {
                      Navigator.pushNamedAndRemoveUntil(context, '/lecturer-main', (route) => false);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                    }
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
                              'Login Success',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: kRedColor,
                        content: Text(state.message),
                      ),
                    );
                  } else {
                    //show snackbar loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: kLoadingColor,
                        content: Row(
                          children: [
                            Text('Loading'),
                            SizedBox(width: 12),
                            SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(strokeWidth: 1),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: 'Login Now',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                    height: 55,
                    backgroundColor: (state is LoginLoading) ? kGreyColor : kPrimaryColor,
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        //Store the data
                        context.read<LoginBloc>().add(
                              LoginUserEvent(
                                emailOrUsername: widget.loginEmailC.text,
                                password: widget.loginPasswordC.text,
                              ),
                            );
                      }
                    },
                    width: double.infinity,
                    borderRadius: 20,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
