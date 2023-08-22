import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_learning_app/data/api_services/api_services.dart';
import 'package:online_learning_app/data/models/course/create_watch_model.dart';

part 'create_watch_event.dart';
part 'create_watch_state.dart';

class CreateWatchBloc extends Bloc<CreateWatchEvent, CreateWatchState> {
  CreateWatchBloc() : super(CreateWatchInitial()) {
    on<CreateWatchedVideos>((event, emit) async {
      emit(CreateWatchLoading());
      try {
        var json = await ApiServices().createWatch(videoId: event.videoId);
        CreateWatchModel data = CreateWatchModel.fromJson(json);
        if (data.result == true) {
          emit(CreateWatchSuccess(data: data));
        } else {
          emit(CreateWatchError(message: data.message.toString()));
        }
      } catch (e) {
        emit(CreateWatchError(message: e.toString()));
      }
    });
  }
}
