import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BackIcon extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const BackIcon({Key? key, this.onPressed,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed??() => Navigator.maybePop(context),
        child: Icon(
          IconlyBroken.arrow_left,
          color: color ?? Colors.white,
        ));
  }
}
