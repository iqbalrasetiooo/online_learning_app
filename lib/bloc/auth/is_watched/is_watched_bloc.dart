import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_learning_app/data/api_services/api_services.dart';

import '../../../data/models/course/is_watched_model.dart';

part 'is_watched_event.dart';
part 'is_watched_state.dart';

class IsWatchedBloc extends Bloc<IsWatchedEvent, IsWatchedState> {
  IsWatchedBloc() : super(IsWatchedInitial()) {
    on<GetIsWatched>((event, emit) async {
      emit(IsWatchedLoading());
      try {
        var json = await ApiServices().getWatchedVideos(videoId: event.videoId);
        IsWatchedModel data = IsWatchedModel.fromJson(json);
        if (data.result == true) {
          emit(IsWatchedSuccess(watched: data));
        } else {
          emit(IsWatchedError(message: data.message.toString()));
        }
      } catch (e) {
        emit(IsWatchedError(message: e.toString()));
      }
    });
  }
}
