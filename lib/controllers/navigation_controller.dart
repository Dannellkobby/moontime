import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/services/all_episodes_provider.dart';

enum NavbarScreens { home, favourites, settings, }

class NavigationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static NavigationController get = Get.find();
  RxBool disableSwipe = true.obs;
  RxBool hideNavBar = false.obs;
  var exitWindowOpen = false;
  var currentIndex = NavbarScreens.home.index.obs;
  Timer exitTimer = Timer(const Duration(milliseconds: 0), () {});
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        initialIndex: NavbarScreens.home.index,
        length: NavbarScreens.values.length,
        vsync: this);
    tabController.addListener(() {
      currentIndex.value = tabController.index;
    });



  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void openExitWindow() {
    if (kDebugMode) {
      print('NavigationController.openExitWindow start: $exitWindowOpen');
    }
    exitWindowOpen = true;
    exitTimer.cancel();
    exitTimer = Timer(const Duration(milliseconds: 3000), () {
      if (kDebugMode) {
        print('NavigationController.openExitWindow end: $exitWindowOpen');
      }
      exitWindowOpen = false;
    });
  }

  void toggleSwipe({required bool disableSwipe}) {
    this.disableSwipe.value = disableSwipe;
  }

  void toggleNavBar({required bool hideNavBar}) {
    this.hideNavBar.value = hideNavBar;
  }

  static void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}