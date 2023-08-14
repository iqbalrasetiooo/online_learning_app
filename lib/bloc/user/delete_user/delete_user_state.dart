part of 'delete_user_bloc.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {
  final String message;
  const DeleteUserSuccess({required this.message});
}

class DeleteUserError extends DeleteUserState {
  final String message;
  const DeleteUserError({required this.message});
}
