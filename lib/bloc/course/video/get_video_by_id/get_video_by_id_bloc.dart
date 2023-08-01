import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_learning_app/data/api_services/api_services.dart';
import 'package:online_learning_app/data/models/course/video_by_id_model.dart';

part 'get_video_by_id_event.dart';
part 'get_video_by_id_state.dart';

class GetVideoByIdBloc extends Bloc<GetVideoByIdEvent, GetVideoByIdState> {
  GetVideoByIdBloc() : super(GetVideoByIdInitial()) {
    on<VideoByIdEvent>((event, emit) async {
      emit(GetVideoByIdLoading());
      try {
        var json = await ApiServices().getVideoById(id: event.id);
        VideoByIdModel data = VideoByIdModel.fromJson(json);
        if (data.result == true) {
          emit(GetVideoByIdSuccess(video: data));
        } else {
          emit(GetVideoByIdError(message: data.message.toString()));
        }
      } catch (e) {
        emit(GetVideoByIdError(message: e.toString()));
      }
    });
  }
}
