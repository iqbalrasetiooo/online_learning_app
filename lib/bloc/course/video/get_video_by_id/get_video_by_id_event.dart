part of 'get_video_by_id_bloc.dart';

abstract class GetVideoByIdEvent extends Equatable {
  const GetVideoByIdEvent();

  @override
  List<Object> get props => [];
}

class VideoByIdEvent extends GetVideoByIdEvent {
  final String id;
  const VideoByIdEvent({required this.id});
}
