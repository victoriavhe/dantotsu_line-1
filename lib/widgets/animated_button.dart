import 'package:dantotsu_line/common/colors.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final bool visible;
  final double width;
  final String buttonText;
  final double radius;

  const AnimatedButton(
      {Key key,
      this.onTap,
      this.visible,
      this.width,
      this.buttonText,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Stack(
        children: <Widget>[
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              width: width,
              height: 70.0,
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(radius)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Center(
            child: InkWell(
              onTap: onTap ?? () {},
              child: Center(
                child: Visibility(
                    visible: visible,
                    child: TextWidget(
                      text: buttonText ?? "",
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    replacement: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 1,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
