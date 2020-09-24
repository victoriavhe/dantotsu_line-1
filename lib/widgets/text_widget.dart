import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const TextWidget(
      {Key key,
      this.text,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.fontFamily,
      this.textAlign,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      overflow: overflow ?? TextOverflow.clip,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
