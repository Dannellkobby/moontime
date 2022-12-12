/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moontime/utilities/colours.dart';

class MoontimePlaceholder extends StatelessWidget {
  final Color? logoColor;
  final double? height;
  final double? blur;
  final double? logoSize;

  const MoontimePlaceholder({
    Key? key,
    this.logoColor,
    this.height,
    this.blur,
    this.logoSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/logo_lettermark.svg',
          height: logoSize ?? 32,
          alignment: Alignment.center,
          color: logoColor ?? Colours.moonBlueLight,
        ),
        BlurryContainer(
          blur: blur ?? 4,
          height: height ?? 100,
          width: double.maxFinite,
          elevation: 0,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
          padding: const EdgeInsets.all(0),
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                const Color(0xFF8EC5FC).withOpacity(0.1),
                const Color(0xFFE0C3FC).withOpacity(0.1),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
