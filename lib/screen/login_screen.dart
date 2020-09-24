import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/bloc/authentication/auth_bloc.dart';
import 'package:dantotsu_line/bloc/authentication/auth_event.dart';
import 'package:dantotsu_line/bloc/authentication/auth_state.dart';
import 'package:dantotsu_line/common/colors.dart';
import 'package:dantotsu_line/helper/shared_preferences_helper.dart';
import 'package:dantotsu_line/model/authentication/login_body.dart';
import 'package:dantotsu_line/model/authentication/login_response.dart';
import 'package:dantotsu_line/screen/report_problem_group_leader/0dashboard.dart';
import 'package:dantotsu_line/widgets/animated_button.dart';
import 'package:dantotsu_line/widgets/app_dialog.dart';
import 'package:dantotsu_line/widgets/circular_progress_widget.dart';
import 'package:dantotsu_line/widgets/text_field_widget.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'flow_admin/0dashboard.dart';
import 'flow_utd_inspector/0unit_produksi.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationBloc loginBloc;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isAnimationStarted = false;
  bool isVisible = true;
  LoginResponse response;
  SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

  var auth = LocalAuthentication();

  //  final LocalAuthentication auth = LocalAuthentication();
  bool isAuth = false;

  @override
  void initState() {
//    initializeFingerprint();
    initializeBloc();
    super.initState();
  }
//
//  void _auth() async {
//    List<BiometricType> availableBiometrics =
//    await auth.getAvailableBiometrics();
//
//    if (Platform.isIOS) {
//      if (availableBiometrics.contains(BiometricType.fingerprint)) {
//        print("Finger");
//        _startBioMetricAuth("Gunakan Touch ID untuk melakukan autentikasi.");
//      }
//    } else {
//      _startBioMetricAuth("Gunakan Fingerprint untuk melakukan autentikasi.");
//    }
//  }

//  void _startBioMetricAuth(String message) async {
//    try {
//      bool didAuthenticate =
//      await auth.authenticateWithBiometrics(localizedReason: message);
//      if (didAuthenticate) {
////        dispatchLogin();
////          Navigator.pushReplacement(
////              context, MaterialPageRoute(builder: (context) => HomeScreen()));
//        print("berhasil");
//      } else {
//        setState(() {
//          print("gagal");
//        });
//      }
//    } on PlatformException catch (e) {
//      print("Error!");
//    }
//  }

//  Future<void> initializeFingerprint() async {
//    String uname, pwd;
//    uname = await sharedPrefsHelper.getUsername();
//    pwd = await sharedPrefsHelper.getPassword();
//
//    if (uname.toLowerCase() == "username" ||
//        uname == null ||
//        pwd.toLowerCase() == "password" ||
//        pwd == null ||
//        uname.isEmpty ||
//        pwd.isEmpty || uname.toLowerCase() == "admin") {
//      showAppDialog(
//          context, "Anda harus login terlebih dahulu untuk bisa menggunakan fingerprint.");
//    } else {
//      _auth();
//    }
//  }

  void initializeBloc() {
    loginBloc = AuthenticationBloc(AuthenticationUninitialized());
  }

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void dispatchLogin() {
    loginBloc.add(Login(LoginBody(
      userName: usernameController.text.toString(),
      password: passwordController.text.toString(),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is AuthenticationError) {
            setState(() {
              isVisible = true;
              isAnimationStarted = false;
            });
            showErrorEmptyDialog(context, state.message, onTap: () {
              Navigator.pop(context);
            });
          } else if (state is AuthenticationAuthenticated) {
            response = state.loginResponse;

            if (response.data != null) {
              sharedPrefsHelper.setToken(response.data.token.toString());
            }

            sharedPrefsHelper.setUsername(usernameController.text.toString());
            sharedPrefsHelper.setPassword(passwordController.text.toString());

            if (response.data.privilege.toString().toUpperCase().contains("LEADER")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DashboardReportProblem(state.loginResponse),
                ),
              );
            } else if (response.data.privilege.toString().toUpperCase() ==
                "INSPECTOR") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UnitProduksiInspector(loginResponse: state.loginResponse),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return loginBody(context);
          } else if (state is ProcessingAuthentication) {
            return CircularProgressWidget();
          }

          return loginBody(context);
        },
      ),
    );
  }

  Widget loginBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 64, right: 64, bottom: 42, top: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400,
            height: 350,
            child: Image.asset(
              "assets/excavator_2.png",
              fit: BoxFit.contain,
            ),
          ),
          TextWidget(
              text: 'WELCOME TO IT LINE',
              fontSize: 40,
              fontWeight: FontWeight.w700),
          SizedBox(height: 50),
          TextFieldWidget(
            controller: usernameController,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            hintText: "Username",
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            controller: passwordController,
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.black,
            ),
            suffixIcon: FlatButton(
              onPressed: () => showPassword(),
              child: Icon(
                Icons.remove_red_eye,
                color: obscureText ? AppColors.primaryColor : Colors.grey,
              ),
            ),
            hintText: "Password",
            obscureText: obscureText,
          ),
          SizedBox(height: 50),
          AnimatedButton(
            buttonText: "Login",
            width:
            isAnimationStarted ? 70.0 : MediaQuery.of(context).size.width,
            visible: isVisible,
            radius: isAnimationStarted ? 70.0 : 0,
            onTap: () {
              if (usernameController.text.toString().isEmpty ||
                  passwordController.text.toString().isEmpty) {
                showErrorEmptyDialog(
                    context, "Username or Password can't be empty", onTap: () {
                  Navigator.pop(context);
                });
              } else {
                setState(() {
                  isVisible = false;
                  isAnimationStarted = true;
                });

                if (usernameController.text.toString().toLowerCase() ==
                    "admin" &&
                    passwordController.text.toString().toLowerCase() ==
                        "123456") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardAdmin()));
                } else {
                  dispatchLogin();
                }
              }
            },
          ),
          SizedBox(height: 40),
//          Text(
//            "— Atau Login menggunakan sidik jari —",
//            style: TextStyle(
//              fontSize: 20,
//              fontWeight: FontWeight.w500,
//            ),
//          ),
//          SizedBox(height: 40),
//          Center(
//            child: CachedNetworkImage(
//              imageUrl:
//              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Fingerprint_picture.svg/707px-Fingerprint_picture.svg.png",
//              height: 70,
//            ),
//          ),
        ],
      ),
    );
  }

  void showScreenDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: TextWidget(text: "Oops!"),
            content: TextWidget(text: "There is something wrong. Try Again!"),
            actions: <Widget>[
              CupertinoButton(
                  child: Text("OK"), onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void showErrorEmptyDialog(BuildContext context, String message,
      {Function onTap}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(18),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      child: TextWidget(
                        text: "$message",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                              child: Container(
                                width: 200,
                                height: 50,
                                color: Colors.orange,
                                child: Center(child: Text("Coba Lagi")),
                              ),
                              onTap: () => onTap()),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

}
