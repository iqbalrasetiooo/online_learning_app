part of 'delete_user_bloc.dart';

abstract class DeleteUserEvent extends Equatable {
  const DeleteUserEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserFromDBEvent extends DeleteUserEvent {
  final String id;
  const DeleteUserFromDBEvent({required this.id});
}
