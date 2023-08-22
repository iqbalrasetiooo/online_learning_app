part of 'is_watched_bloc.dart';

class IsWatchedState extends Equatable {
  const IsWatchedState();

  @override
  List<Object> get props => [];
}

class IsWatchedInitial extends IsWatchedState {}

class IsWatchedLoading extends IsWatchedState {}

class IsWatchedError extends IsWatchedState {
  final String message;
  const IsWatchedError({required this.message});
}

class IsWatchedSuccess extends IsWatchedState {
  final IsWatchedModel watched;
  const IsWatchedSuccess({required this.watched});
}
