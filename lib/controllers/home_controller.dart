import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/all_shows_provider.dart';
import 'package:moontime/services/all_episodes_provider.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:tuple/tuple.dart';

class HomeController extends GetxController with StateMixin<Tuple2<List<Episode>?, List<Show>?>> {

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
        if (response.hasError) {
          onError(response.statusText);
          response.statusText;
        } else {
          episodes = response.body;
          shows = Show.listFromJson(seriesProvider.getSeries().reversed);
          change(Tuple2(episodes!, shows!), status: RxStatus.success());
        }
      },
    );

  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to load Airing Episodes', message: '$err');
    change(null, status: RxStatus.error(err.toString()));
  }
}
