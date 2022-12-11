import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/controllers/episode_details_controller.dart';
import 'package:moontime/controllers/navigation_controller.dart';
import 'package:moontime/controllers/person_details_controller.dart';
import 'package:moontime/controllers/show_details_controller.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/person.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/all_shows_provider.dart';
import 'package:moontime/services/all_episodes_provider.dart';
import 'package:moontime/services/cast_in_episode_provider.dart';
import 'package:moontime/services/cast_in_show_provider.dart';
import 'package:moontime/services/episodes_in_show_provider.dart';
import 'package:moontime/services/person_provider.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/screens/episode_details.dart';
import 'package:moontime/views/screens/main_layout.dart';
import 'package:moontime/views/screens/person_details.dart';
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
          Get.lazyPut<ShowDetailsController>(() =>
              ShowDetailsController(
                  episodesInShowProvider: Get.find(),
                  castInShowProvider: Get.find()));
          Get.put<CastInShowProvider>(CastInShowProvider(showID:
          (Get.arguments[Strings.keyShow] as Show).id));
          Get.put<EpisodesInShowProvider>(EpisodesInShowProvider(showID:
              (Get.arguments[Strings.keyShow] as Show).id));
        })),
    GetPage(
        name: Strings.routeEpisodeDetails,
        page: () => EpisodeDetails(episode: Get.arguments[Strings.keyEpisode]),
        binding: BindingsBuilder(() {
          Get.lazyPut<EpisodeDetailsController>(() => EpisodeDetailsController(castInEpisodeProvider: Get.find(), castInShowProvider: Get.find()));
          Get.put<CastInShowProvider>(CastInShowProvider(showID:
              (Get.arguments[Strings.keyShow] as Show).id));
          Get.put<CastInEpisodeProvider>(CastInEpisodeProvider(episodeID:
              (Get.arguments[Strings.keyEpisode] as Episode).id));
        })),
    GetPage(
        name: Strings.routePersonDetails,
        page: () => PersonDetails(person: Get.arguments[Strings.keyPerson]),
        binding: BindingsBuilder(() {
          Get.lazyPut<PersonDetailsController>(() => PersonDetailsController(personProvider:  Get.find()));
          Get.put<PersonCastsProvider>(PersonCastsProvider(personID:
              (Get.arguments[Strings.keyPerson] as Person).id));

        })),
  ];
}
