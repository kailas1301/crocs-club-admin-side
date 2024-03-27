part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class FetchUsers extends UsersEvent {}

class BlockUser extends UsersEvent {
  final int userId;

  BlockUser(this.userId);
}

class UnblockUser extends UsersEvent {
  final int userId;

  UnblockUser(this.userId);
}