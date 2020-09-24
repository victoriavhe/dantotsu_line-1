import 'package:dantotsu_line/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      _navigateToDashboard();
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    return true;
  }

  void _navigateToDashboard() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white10,
          ),
          Center(
            child: Container(
              height: SizeConfig.safeBlockVertical * 60,
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.amber,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1,
                          bottom: SizeConfig.safeBlockVertical * 3),
                      child: Center(
                        child: Text(
                          "Dantotsu Line iOS Mobile",
                          style: TextStyle(
                            fontFamily: 'Sail',
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.safeBlockVertical * 4,
                            shadows: <Shadow>[
                              Shadow(
                                blurRadius: 18.0,
                                color: Colors.black54,
                                offset: Offset.fromDirection(120, 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
