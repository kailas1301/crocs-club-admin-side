import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final http.Client httpClient;

  LoginBlocBloc(this.httpClient) : super(LoginBlocInitial()) {
    on<AdminLoginButtonPressed>((event, emit) async {
      emit(LoginBlocLoading());
      try {
        print('the email is ${event.email}');
        print('the password is ${event.password}');

        final response = await httpClient.post(
          Uri.parse('http://10.0.2.2:8080/admin/adminlogin'),
          body: jsonEncode({
            'email': event.email,
            'password': event.password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(LoginBlocSuccess());
        } else {
          final errorJson = jsonDecode(response.body);
          final errorMessage = errorJson['message'] ?? 'Unknown error occurred';
          emit(LoginBlocError(errorMessage));
        }
      } catch (e) {
        emit(LoginBlocError('An error occurred: $e'));
      }
    });
  }
}
