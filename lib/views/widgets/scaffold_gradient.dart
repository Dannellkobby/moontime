/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class ScaffoldGradient extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool? primary;
  final PreferredSizeWidget? appBar;

  const ScaffoldGradient(
      {Key? key,
      required this.body,
      this.primary,
      this.appBar,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
                    const Color(0xFF100417),
                    const Color(0xFF051013),
                  ]
                : [
                    const Color(0xFFE5EEF8),
                    const Color(0xFFF9F6FC),
                  ],
          )),
        ),
        Scaffold(
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          primary: primary ?? false,
          appBar: appBar,
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }
}
