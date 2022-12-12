import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';

void toastExitApp() {
  Get.closeCurrentSnackbar();
  Get.snackbar('', '',
      colorText: (Theme.of(Get.context!).brightness == Brightness.dark)
          ? Colors.white
          : Colours.darkShade500,
      icon: const SizedBox.shrink(),
      shouldIconPulse: true,
      backgroundColor: Theme.of(Get.context!).colorScheme.surface,
      margin: const EdgeInsets.all(0),
      snackStyle: SnackStyle.GROUNDED,
      mainButton: TextButton(
          onPressed: () {},
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: (Theme.of(Get.context!).brightness == Brightness.dark)
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () => NavigationController
                .exitApp(), // Navigator.maybePop(Get.context!),
          )),
      messageText: Text(
        "Tap again to exit\n",
        style: Theme.of(Get.context!).textTheme.subtitle2,
      ),
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 4));
}

void toastError({
  required String title,
  String? message,
  SnackPosition? position,
  TextButton? mainButton,
  Duration? duration,
  Duration? animationDuration,
}) {
  Get.closeCurrentSnackbar();
  Get.snackbar(title, message ?? '',
      colorText: Colors.white,
      mainButton: mainButton,
      backgroundColor: Colours.redError,
      snackPosition: position ?? SnackPosition.TOP,
      margin: const EdgeInsets.all(0),
      snackStyle: SnackStyle.GROUNDED,
      animationDuration: animationDuration ?? const Duration(milliseconds: 200),
      duration: duration ?? const Duration(seconds: 8));
}

getDividerHorizontal({BuildContext? context,
  double? height,
  double? width,
  Color? color,
  double? top,
  double? bottom,
  EdgeInsets? margin}) {
  context ??= Get.context!;
  return Container(
    width: width ?? context.width,
    margin: EdgeInsets.only(top: top ?? kEdgePadding / 2,
      bottom: bottom ?? kEdgePadding / 2,
      left: kEdgePadding / 2,
      right: kEdgePadding / 2,),
    height: height ?? 2,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colours.transparentB,
          color??((Theme
              .of(Get.context!)
              .brightness == Brightness.dark)
              ? Colours.darkShade600
              : Colours.lightShade300),
          Colours.transparentB,
        ], begin: Alignment.centerLeft, end: Alignment.centerRight)),

    // color: widget.trailingDividerColor ??
    //     Colours.darkShade200,
  );
}

getDividerVertical({BuildContext? context,
  double? height,
  double? width,
  double? top,
  Color? color,
  double? bottom,
  EdgeInsets? margin}) {
  context ??= Get.context!;
  return Container(
    height: height ?? context.height,
    margin: EdgeInsets.only(top: top ?? 0,
      bottom: bottom ?? 0,
      left: kEdgePadding / 2,
      right: kEdgePadding / 2,),
    // margin: margin ?? const EdgeInsets.symmetric(horizontal: kEdgePadding / 2),
    width: width ?? 1,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colours.transparentW,
          color??((Theme
              .of(Get.context!)
              .brightness == Brightness.dark)
              ? Colours.darkShade600
              : Colours.lightShade300),
          Colours.transparentW,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

  );
}

Widget getCircularProgressIndicator({double width = 32, double height = 32, double strokeWidth = 2}) {
  return Center(
    child: SizedBox(
      width: width,
      height: height,
      child:  CircularProgressIndicator(
        strokeWidth: strokeWidth,
        backgroundColor: Colours.moonBlueLight,
        valueColor: const AlwaysStoppedAnimation<Color>(Colours.moonBlueDeep),
      ),
    ),
  );
}
