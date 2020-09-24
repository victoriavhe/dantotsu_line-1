import 'package:dantotsu_line/model/authentication/login_body.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class Login extends AuthenticationEvent {
  final LoginBody body;

  Login(this.body) : super();
}

class Logout extends AuthenticationEvent {
  final BuildContext context;

  Logout(this.context);
}
