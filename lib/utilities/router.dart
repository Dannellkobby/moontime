import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/episode_details_controller.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/person_details_controller.dart';
import 'package:moontime/controllers/search_controller.dart';
import 'package:moontime/controllers/show_details_controller.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/person.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/all_shows_provider.dart';
import 'package:moontime/services/airing_episodes_provider.dart';
import 'package:moontime/services/person_provider.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/screens/episode_details.dart';
import 'package:moontime/views/screens/main_layout.dart';
import 'package:moontime/views/screens/person_details.dart';
import 'package:moontime/views/screens/search.dart';
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
          Get.put<AiringEpisodesProvider>(AiringEpisodesProvider());
          Get.put<AllSeriesProvider>(AllSeriesProvider());
          Get.put<NavigationController>(NavigationController());
        })),
    GetPage(
        name: Strings.routeShowDetails,
        preventDuplicates: true,
        page: () {
          Get.find<ShowDetailsController>().showID.value = '${(Get.arguments[Strings.keyShow] as Show).id}';
          return ShowDetails(show: Get.arguments[Strings.keyShow]);
        },
        binding: BindingsBuilder(() {
          Get.put<ShowDetailsController>(ShowDetailsController());
        })),
    GetPage(
        name: Strings.routeEpisodeDetails,
        preventDuplicates: true,
        page: () {
          Get.find<EpisodeDetailsController>().episodeID.value = '${(Get.arguments[Strings.keyEpisode] as Episode).id}';
         return EpisodeDetails(episode: Get.arguments[Strings.keyEpisode]);},
        binding: BindingsBuilder(() {
          Get.lazyPut<EpisodeDetailsController>(() => EpisodeDetailsController());
        })),
    GetPage(
        name: Strings.routePersonDetails,
        page: () => PersonDetails(person: Get.arguments[Strings.keyPerson]),
        binding: BindingsBuilder(() {
          Get.lazyPut<PersonDetailsController>(
              () => PersonDetailsController(personProvider: Get.find()));
          Get.put<PersonCastsProvider>(PersonCastsProvider(
              personID: (Get.arguments[Strings.keyPerson] as Person).id));
        })),
    GetPage(
      name: Strings.routeSearch,
      preventDuplicates: false,
      transitionDuration: const Duration(milliseconds: 400),
      page: () => const Search(),
      binding: BindingsBuilder(() {
        Get.put<SearchController>(SearchController(Get.arguments));
      }),
    ),
  ];
}
