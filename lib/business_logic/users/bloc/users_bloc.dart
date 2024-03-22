import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/models/users.dart';
import 'package:crocsclub_admin/data/repositories/users_repo.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersRepository usersRepository = UsersRepository();
  UsersBloc() : super(UsersInitial()) {
    on<FetchUsers>((event, emit) async {
      try {
        emit(UsersLoading());
        final users = await usersRepository.fetchUsers();
        emit(UsersLoaded(users));
      } catch (error) {
        emit(UsersError(error.toString())); // Handle error more gracefully
      }
    });
  }
}
