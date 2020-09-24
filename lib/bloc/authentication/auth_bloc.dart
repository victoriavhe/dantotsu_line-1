import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/services/repository/auth/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final tag = "AuthenticationBloc";
  final AuthRepository _authRepository = AuthRepository();

  AuthenticationBloc(AuthenticationState initialState) : super(initialState);

  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield AuthenticationUninitialized();
    } else if (event is Login) {
      try {
        LoginResponse response = await _authRepository.doLogin(event.body);
        yield ProcessingAuthentication();
        print(response.result.toString());
        if (response.result.toString().toUpperCase() == "SUCCESS") {
          print(response.result.toString());
          yield AuthenticationAuthenticated(response);
        } else if (response.result.toString().toUpperCase() == "ERROR") {
          print(response.result.toString());
          yield AuthenticationError(response.message);
        }
      } on Exception catch (e) {
        yield AuthenticationError(e.toString());
        print(e);
      }
    } else if (event is Logout) {
      yield LoggingOut();
      try {} on Exception catch (e) {
        print(e);
      }
      //REMOVE CREDENTIAL HERE
      yield UserLoggedOut();
    }
  }
}
