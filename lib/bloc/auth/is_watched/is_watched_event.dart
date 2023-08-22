part of 'is_watched_bloc.dart';

class IsWatchedEvent extends Equatable {
  const IsWatchedEvent();

  @override
  List<Object> get props => [];
}

class GetIsWatched extends IsWatchedEvent {
  final String videoId;
  const GetIsWatched({required this.videoId});
}
