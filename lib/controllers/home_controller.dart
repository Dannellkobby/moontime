import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/all_shows_provider.dart';
import 'package:moontime/services/all_episodes_provider.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:tuple/tuple.dart';

class HomeController extends GetxController

    with StateMixin<Tuple2<List<Episode>?, List<Show>?>> {

  // with StateMixin<>  {
  final AllEpisodesProvider episodesProvider;
  final AllSeriesProvider seriesProvider;
  List<Episode>? episodes;
  List<Show>? shows;

  HomeController(
      {required this.episodesProvider, required this.seriesProvider});

  @override
  void onInit() {
    super.onInit();
    episodesProvider.getEpisodes().then(
      (response) {
        // if (kDebugMode) {
        //   print('getEpisodes.status: ${response.status.code}');
        //   print('getEpisodes.statusText: ${response.statusText}');
        //   print('getEpisodes.hasError: ${response.hasError}');
        //   print('getEpisodes.request: ${response.request}');
        //   print('getEpisodes.isOk: ${response.isOk}');
        // }
        if (response.hasError) {
          onError(response.statusText);
          response.statusText;
        } else {
          episodes = response.body;
          shows = Show.listFromJson(seriesProvider.getSeries());
          change(Tuple2(episodes!, shows!), status: RxStatus.success());
        }
      },
    );

    //change(Tuple2(episodes, shows), status: RxStatus.success());
  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to get Showing Episodes', message: '$err');
    change(null, status: RxStatus.error(err.toString()));
  }
}
