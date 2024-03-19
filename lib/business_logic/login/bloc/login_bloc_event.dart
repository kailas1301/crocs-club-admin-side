part of 'login_bloc_bloc.dart';

sealed class LoginBlocEvent {}

class AdminLoginButtonPressed extends LoginBlocEvent {
  final String email;
  final String password;

  AdminLoginButtonPressed({required this.email, required this.password});
}
