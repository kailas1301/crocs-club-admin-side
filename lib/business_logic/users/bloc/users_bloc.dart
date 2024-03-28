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

    on<BlockUser>((event, emit) async {
      try {
        await usersRepository.blockUser(event.userId);
        final updatedUsers = await usersRepository.fetchUsers();
        final blockedUserId = event.userId;

        emit(UserBlocked(blockedUserId));
        emit(UsersLoaded(updatedUsers));
      } catch (error) {
        emit(UsersError(error.toString()));
      }
    });

    on<UnblockUser>((event, emit) async {
      try {
        await usersRepository.unblockUser(event.userId);
        final updatedUsers = await usersRepository.fetchUsers();
        final unblockedUserId = event.userId;

        emit(UserUnblocked(unblockedUserId));
        emit(UsersLoaded(updatedUsers));
      } catch (error) {
        emit(UsersError(error.toString()));
      }
    });
  }
}
