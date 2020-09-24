import 'dart:ui';

import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AtomicSerialNumber extends StatelessWidget {
  final String serialNumber;

  const AtomicSerialNumber({Key key, this.serialNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextWidget(
          text: "SN",
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          width: 20,
        ),
        TextWidget(
          text: serialNumber ?? "",
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.red,
        )
      ],
    );
  }
}
