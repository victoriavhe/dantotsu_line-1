import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NullPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextWidget(
          text: "Tidak ada data.",
          fontSize: 20,
        ),
      ),
    );
  }
}
