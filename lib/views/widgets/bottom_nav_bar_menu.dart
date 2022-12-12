/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/utilities/colours.dart';

class BottomNavBarMenu extends StatelessWidget {
  final double? iconSize;
  final String? icon;
  final String? iconPressed;
  final Widget? iconWidget;
  final Widget? iconWidgetPressed;
  final String? title;
  final int? index;
  final VoidCallback? onPress;

  const BottomNavBarMenu(
      {Key? key,
      this.iconSize,
      this.icon,
      this.iconPressed,
      this.title,
      this.index,
      this.onPress,
      this.iconWidget,
      this.iconWidgetPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('selected ${index}');

    return Obx(() {
      final selected =
          NavigationController.get.currentIndex.value == (index ?? -1);
      return Expanded(
        child: Material(
          type: MaterialType.transparency,
          shape: const CircleBorder(),
          child: InkWell(
            // shape: const CircleBorder(),
            highlightColor: Colours.transparentB,
            customBorder: const CircleBorder(),
            onTap: onPress == null
                ? null
                : () {
                    onPress!.call();
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  child: (iconWidget != null)
                      ? selected
                          ? iconWidgetPressed!
                          : iconWidget!
                      : SvgPicture.asset(
                          selected ? iconPressed! : icon!,
                          alignment: Alignment.center,
                          height: iconSize ?? 20,
                          allowDrawingOutsideViewBox: true,
                          clipBehavior: Clip.none,
                        ),
                ),
                if (/*selected &&*/ title != null) const SizedBox(height: 4),
                if (/*selected &&*/ title != null)
                  SizedBox(
                    height: 11,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title!,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w500),
                        )),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
