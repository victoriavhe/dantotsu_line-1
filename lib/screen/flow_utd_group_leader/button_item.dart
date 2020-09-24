import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonItem extends StatefulWidget {
  final Model defect;
  final ValueChanged<bool> isSelected;

  const ButtonItem({Key key, this.defect, this.isSelected}) : super(key: key);

  @override
  _ButtonItemState createState() => _ButtonItemState();
}

class _ButtonItemState extends State<ButtonItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected ? Colors.red
                : Color(0xFF124cbf),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: TextWidget(
            textAlign: TextAlign.center,
            text: widget.defect.name,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
