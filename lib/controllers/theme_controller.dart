/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeEnums { light, dark, system }

class ThemeController extends GetxController {
  static ThemeController get get => Get.find();
  final Rx theme = ThemeEnums.system.obs;
  final store = GetStorage();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeEnums get currentTheme => theme.value;

  Future<void> setThemeMode(ThemeEnums value) async {
    theme.value = value;
    _themeMode = getThemeModeFromString(value);
    Get.changeThemeMode(_themeMode);
    await store.write('theme', value.toString()).then((value) {
      update();
    });
  }

  Future<void> switchTheme() async {
    setThemeMode(Get.isDarkMode ? ThemeEnums.light : ThemeEnums.dark);
  }

  ThemeMode getThemeModeFromString(ThemeEnums themeString) {
    ThemeMode setThemeMode = ThemeMode.system;
    if (themeString == ThemeEnums.light) {
      setThemeMode = ThemeMode.light;
    }
    if (themeString == ThemeEnums.dark) {
      setThemeMode = ThemeMode.dark;
    }
    return setThemeMode;
  }

  initThemeModeFromStorage() async {
    final themePref = await store.read('theme') ?? ThemeEnums.dark;
    setThemeMode(themePref == ThemeEnums.light.toString()
        ? ThemeEnums.light
        : themePref == ThemeEnums.dark.toString()
            ? ThemeEnums.dark
            : ThemeEnums.system);
    if (kDebugMode) {
      print('initThemeModeFromStorage: $themePref');
    }
  }

  // checks whether darkmode is set via system or previously by user
  RxBool get isDarkMode {
    if (currentTheme == ThemeEnums.system) {
      if (WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark) {
        return RxBool(true);
      }
    } else if (currentTheme == ThemeEnums.dark) {
      return RxBool(true);
    }
    return RxBool(false);
  }

  @override
  void onInit() {
    super.onInit();
    initThemeModeFromStorage();
  }
}
