part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final String message;
  const UpdateUserSuccess({required this.message});
}

class UpdateUserError extends UpdateUserState {
  final String message;
  const UpdateUserError({required this.message});
}
