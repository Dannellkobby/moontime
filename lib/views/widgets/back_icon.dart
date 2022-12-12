import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BackIcon extends StatelessWidget {
  final Color? color;

  const BackIcon({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.maybePop(context),
        child: Icon(
          IconlyBroken.arrow_left,
          color: color ?? Colors.white,
        ));
  }
}
