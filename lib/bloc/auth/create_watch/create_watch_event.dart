part of 'create_watch_bloc.dart';

class CreateWatchEvent extends Equatable {
  const CreateWatchEvent();

  @override
  List<Object> get props => [];
}

class CreateWatchedVideos extends CreateWatchEvent {
  final String videoId;
  const CreateWatchedVideos({required this.videoId});
}
