import 'package:online_learning_app/export.dart';
import 'package:online_learning_app/screens/user/user_edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Divider(),
                const SizedBox(height: 16),
                BlocBuilder<CheckLoginBloc, CheckLoginState>(
                  builder: (context, state) {
                    if (state is CheckLoginSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nama Lengkap',
                            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semibold),
                          ),
                          Text(
                            state.data.name,
                            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                          ),
                        ],
                      );
                    } else {
                      return BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Lengkap',
                                  style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semibold),
                                ),
                                Text(
                                  state.user.data!.name!.toString(),
                                  style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
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
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                BlocBuilder<CheckLoginBloc, CheckLoginState>(
                  builder: (context, state) {
                    if (state is CheckLoginSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semibold),
                          ),
                          Text(
                            state.data.email,
                            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                          ),
                        ],
                      );
                    } else {
                      return BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semibold),
                                ),
                                Text(
                                  state.user.data!.email!.toString(),
                                  style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
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
                const SizedBox(height: 16),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
