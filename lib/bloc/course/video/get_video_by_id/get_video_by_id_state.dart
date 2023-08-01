part of 'get_video_by_id_bloc.dart';

abstract class GetVideoByIdState extends Equatable {
  const GetVideoByIdState();

  @override
  List<Object> get props => [];
}

class GetVideoByIdInitial extends GetVideoByIdState {}

class GetVideoByIdLoading extends GetVideoByIdState {}

class GetVideoByIdSuccess extends GetVideoByIdState {
  final VideoByIdModel video;
  const GetVideoByIdSuccess({required this.video});
}

class GetVideoByIdError extends GetVideoByIdState {
  final String message;
  const GetVideoByIdError({required this.message});
}
