part of 'create_watch_bloc.dart';

class CreateWatchState extends Equatable {
  const CreateWatchState();

  @override
  List<Object> get props => [];
}

class CreateWatchInitial extends CreateWatchState {}

class CreateWatchLoading extends CreateWatchState {}

class CreateWatchSuccess extends CreateWatchState {
  final CreateWatchModel data;
  const CreateWatchSuccess({required this.data});
}

class CreateWatchError extends CreateWatchState {
  final String message;
  const CreateWatchError({required this.message});
}
