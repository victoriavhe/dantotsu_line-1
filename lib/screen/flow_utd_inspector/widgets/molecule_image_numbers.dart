import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu_line/model/utd/utd_checkpoint.dart';
import 'package:flutter/material.dart';

class MoleculeImageNumbers extends StatelessWidget {
  final ImageCP imageCP;
  final Function onTap;
  final double screenPadding;
  final List<Widget> children;

  const MoleculeImageNumbers(
      {Key key, this.imageCP, this.onTap, this.screenPadding, this.children})
      : assert(
          children != null,
          screenPadding != null,
        );

  @override
  Widget build(BuildContext context) {
    var comparison = double.parse(imageCP.width) /
        (MediaQuery.of(context).size.width - ((screenPadding * 2) + 10));
    return Stack(children: [
      Center(
        child: Container(
          width: double.parse(imageCP.width),
          height: double.parse(imageCP.height) / comparison,
          child: CachedNetworkImage(
            imageUrl: imageCP.image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      Container(
        width: double.parse(imageCP.width),
        height: double.parse(imageCP.height) / comparison,
        child: Stack(
          children: children,
        ),
      )
    ]);
  }
}
