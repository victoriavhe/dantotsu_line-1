import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 10,
        ),
      ),
    );
  }
}
