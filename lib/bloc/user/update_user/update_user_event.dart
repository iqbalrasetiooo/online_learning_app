part of 'update_user_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUser extends UpdateUserEvent {
  final String id;
  String gender = '';
  String dateOfBirth = '';
  String bio = '';
  String imgUrl = '';
  String fullName = '';
  String username = '';
  UpdateUser(
    this.gender,
    this.dateOfBirth,
    this.bio,
    this.imgUrl,
    this.fullName,
    this.username, {
    required this.id,
  });
}
