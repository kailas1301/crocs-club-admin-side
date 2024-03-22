part of 'users_bloc.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;

  UsersLoaded(this.users);
}

class UsersError extends UsersState {
  final String error;

  UsersError(this.error);
}
