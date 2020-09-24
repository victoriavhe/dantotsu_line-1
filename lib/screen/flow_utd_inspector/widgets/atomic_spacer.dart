import 'package:flutter/material.dart';

class AtomicSpacer extends StatelessWidget {
  final bool isHeight;
  final double size;

  const AtomicSpacer({Key key, this.isHeight, this.size})
      : assert(isHeight != null);

  @override
  Widget build(BuildContext context) {
    return isHeight
        ? SizedBox(
            height: size ?? 20,
          )
        : SizedBox(
            width: size ?? 20,
          );
  }
}
