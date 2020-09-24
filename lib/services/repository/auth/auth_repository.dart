import 'package:dantotsu_line/model/authentication/login_body.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/model/authentication/logout_response.dart';
import 'package:dantotsu_line/services/api/auth/auth_api.dart';

class AuthRepository {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();

  Future<LoginResponse> doLogin(LoginBody body) =>
      _authenticationAPI.postLogin(body);

  Future<LogoutResponse> doLogout() =>
      _authenticationAPI.postLogout();
}
