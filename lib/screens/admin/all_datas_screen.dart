import 'package:online_learning_app/bloc/user/get_user_bloc.dart';

import '../../bloc/user/delete_user/delete_user_bloc.dart';
import '../../export.dart';

class AllDataScreen extends StatefulWidget {
  const AllDataScreen({super.key});

  @override
  State<AllDataScreen> createState() => _AllDataScreenState();
}

class _AllDataScreenState extends State<AllDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetUserBloc>().add(GetAllUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('All User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<GetUserBloc, GetUserState>(
          builder: (context, state) {
            if (state is GetUserSuccess) {
              var dataLength = state.user.data!.length;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: dataLength,
                itemBuilder: (context, index) {
                  var data = state.user.data![index];
                  print(data);
                  return ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(data.name!),
                    subtitle: Text(data.email!),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                ('Delete User'),
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: bold,
                                ),
                              ),
                              content: Text(
                                'Are you sure want to delete ${data.name}?',
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
                                    BlocListener<DeleteUserBloc, DeleteUserState>(
                                      bloc: context.read<DeleteUserBloc>()..add(DeleteUserFromDBEvent(id: data.id.toString())),
                                      listener: (context, state) {
                                        if (state is DeleteUserSuccess) {
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
                                          Navigator.pop(context);
                                        } else if (state is DeleteUserError) {
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              );
            } else if (state is GetUserError) {
              return const Center(child: Text('Error'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
