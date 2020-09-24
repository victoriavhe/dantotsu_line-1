import 'package:dantotsu_line/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAppDialog(BuildContext context, String message,
    {String buttonText, Function onTap}) {
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
                              child: Center(
                                  child: Text(buttonText ?? "Coba Lagi")),
                            ),
                            onTap: onTap ?? () => Navigator.pop(context)),
                      ],
                    ),
                  )
                ],
              ),
            ));
      });
}

showQuestionDialog(BuildContext context, String question,
    {Function onYes, Function onNo}) {
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
                      text: "$question",
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
                              width: 100,
                              height: 50,
                              color: Colors.orange,
                              child: Center(child: Text("YA")),
                            ),
                            onTap: () => onYes()),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                            child: Container(
                              width: 100,
                              height: 50,
                              color: Colors.orange,
                              child: Center(child: Text("TIDAK")),
                            ),
                            onTap: () => onNo()),
                      ],
                    ),
                  )
                ],
              ),
            ));
      });
}
