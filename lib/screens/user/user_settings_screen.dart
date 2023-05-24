import 'package:online_learning_app/bloc/auth/check_login/check_login_bloc.dart';
import 'package:online_learning_app/constant/storage_services.dart';
import 'package:online_learning_app/export.dart';

class SettingsScreen extends StatelessWidget {
  final Map<String, String> arguments;

  SettingsScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<CheckLoginBloc, CheckLoginState>(
                      builder: (context, state) {
                        if (state is CheckLoginSuccess) {
                          return Text(
                            state.data.name,
                            style: blackTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          );
                        } else {
                          return BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSuccess) {
                                return Text(
                                  state.user.data!.name.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: bold,
                                  ),
                                );
                              } else {
                                return Column(
                                  children: [
                                    Text(
                                      'User not logged in',
                                      style: redTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: regular,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.person),
                      title: Text('My Profile'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    InkWell(
                      onTap: () {
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
                      child: const ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
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
  }
}
