import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  final LoginResponse loginResponse;

  AuthenticationAuthenticated(this.loginResponse);

  @override
  String toString() => 'AuthenticationAuthenticated';
}

class ProcessingAuthentication extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}

class LoggingOut extends AuthenticationState {}

class UserLoggedOut extends AuthenticationState {}
