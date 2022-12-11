import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/show_details_controller.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/all_shows_provider.dart';
import 'package:moontime/services/all_episodes_provider.dart';
import 'package:moontime/services/episodes_in_show_provider.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/screens/main_layout.dart';
import 'package:moontime/views/screens/show_details.dart';

class MoonRouter {
  MoonRouter._(); //this is to prevent anyone from instantiating this object

  static dynamic callback(Routing? callback) {
    if (kDebugMode) print('MoonRouter.callback ${callback?.current}');
  }

  static final pages = [
    GetPage(
        name: Strings.routeMain,
        page: () => const MainLayout(),
        binding: BindingsBuilder(() {
          Get.put<AllEpisodesProvider>(AllEpisodesProvider());
          Get.put<AllSeriesProvider>(AllSeriesProvider());
          Get.put<NavigationController>(NavigationController());
        })),
    GetPage(
        name: Strings.routeShowDetails,
        page: () => ShowDetails(show: Get.arguments[Strings.keyShow]),
        binding: BindingsBuilder(() {
          Get.lazyPut<ShowDetailsController>(() => ShowDetailsController(episodesInShowProvider: Get.find()));
          Get.put<EpisodesInShowProvider>(EpisodesInShowProvider(
              (Get.arguments[Strings.keyShow] as Show).id));
        })),
  ];
}
