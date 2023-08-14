import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_learning_app/data/api_services/api_services.dart';
import 'package:online_learning_app/data/models/course/delete_model.dart';

part 'delete_user_event.dart';
part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  DeleteUserBloc() : super(DeleteUserInitial()) {
    on<DeleteUserFromDBEvent>((event, emit) async {
      emit(DeleteUserLoading());
      try {
        var json = await ApiServices().deleteUser(id: event.id);
        DeleteModel data = DeleteModel.fromJson(json);
        if (data.result == true) {
          emit(DeleteUserSuccess(message: data.message.toString()));
        } else {
          emit(DeleteUserSuccess(message: data.message.toString()));
        }
      } catch (e) {
        emit(DeleteUserSuccess(message: e.toString()));
      }
    });
  }
}
