part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class FetchUsers extends UsersEvent {}
