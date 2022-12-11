import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/services/cast_in_show_provider.dart';
import 'package:moontime/services/episodes_in_show_provider.dart';
import 'package:moontime/utilities/widgets.dart';
import "package:collection/collection.dart";
import 'package:tuple/tuple.dart';

class ShowDetailsController extends GetxController
    with StateMixin<Tuple2<List<Cast>?, List<Episode>?>> {


  final EpisodesInShowProvider episodesInShowProvider;
  List<Episode>? episodes;
  Map<int, List<Episode>>? seasonsAndEpisodes;
  List<Cast>? showCast;
  final CastInShowProvider castInShowProvider;

  ShowDetailsController(
      {required this.castInShowProvider, required this.episodesInShowProvider});

  @override
  void onInit() {
    super.onInit();
    castInShowProvider.getShowCast().then(
      (response) {
        if (response.hasError) {
          onError(response.statusText);
          response.statusText;
        } else {
          showCast = response.body;
        }
        episodesInShowProvider.getEpisodes().then(
              (response) {
            if (response.hasError) {
              onError(response.statusText);
              response.statusText;
            } else {
              episodes = response.body;
              seasonsAndEpisodes =  groupBy(episodes!.map((e) => e), (p0) => p0.season);
              change(Tuple2(showCast, episodes), status: RxStatus.success());
            }
          },
        ).catchError(onError);

      },
    ).catchError(onError);

  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to load Episodes', message: '$err');
    change(null, status: RxStatus.error(err.toString()));
  }
}
