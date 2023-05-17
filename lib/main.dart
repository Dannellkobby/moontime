/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/theme_controller.dart';
import 'package:moontime/services/initialize.dart';
import 'package:moontime/utilities/router.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/utilities/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Get.putAsync(() => AppInitialization().init());
  runApp(GetMaterialApp(
    navigatorObservers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    debugShowCheckedModeBanner: false,
    theme: Themes.lightThemeData,
    darkTheme: Themes.darkThemeData,
    title: 'Moontime',
    routingCallback: MoonRouter.callback,
    getPages: MoonRouter.pages,
    themeMode: ThemeController.get.themeMode,
    initialRoute: Strings.routeMain,
  ));
}
///**TODO
/// logo Appbar issues**//
/// bottom navbar spacing
/// show related series
/// loading placeholder
/// favourite episodes, actors
/// on showdetailsview, show medium image before full image
/// internet connection listener. try again
/// remove fake rating replace with genre
/// FIREABSE
///   log date added to favourite
///   log analytics for favourites
///   log device details on signup