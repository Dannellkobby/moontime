import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moontime/controllers/home_controller.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/show_details_controller.dart';
import 'package:moontime/controllers/theme_controller.dart';
import 'package:moontime/firebase_options.dart';

class AppInitialization extends GetxService {
  Future init() async {
    await GetStorage.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put<NavigationController>(NavigationController());
    Get.put<ThemeController>(ThemeController());
    Get.lazyPut<ShowDetailsController>(() => ShowDetailsController());
    Get.lazyPut<HomeController>(() => HomeController(
        airingEpisodes: Get.find(), seriesProvider: Get.find()));

    Future.delayed(const Duration(seconds: 2)).then((value) {
      //TODO Add splashscreen
      // FlutterNativeSplash.remove();
    });
    if (kDebugMode) print('APP INITIALIZATION DONE');
    return this;
  }
}
