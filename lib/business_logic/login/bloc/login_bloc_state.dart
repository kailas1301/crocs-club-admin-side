part of 'login_bloc_bloc.dart';

sealed class LoginBlocState {}

final class LoginBlocInitial extends LoginBlocState {}

final class LoginBlocLoading extends LoginBlocState {}

final class LoginBlocSuccess extends LoginBlocState {}

final class LoginBlocError extends LoginBlocState {
  final String errorText;
  LoginBlocError(this.errorText);
}
