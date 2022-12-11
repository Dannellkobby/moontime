import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/services/episodes_in_show_provider.dart';
import 'package:moontime/utilities/widgets.dart';
import "package:collection/collection.dart";

class ShowDetailsController extends GetxController with StateMixin<List<Episode>?> {

  final EpisodesInShowProvider episodesInShowProvider;
  List<Episode>? episodes;
  Map<int, List<Episode>>? seasonsAndEpisodes;

  ShowDetailsController(
      {required this.episodesInShowProvider});

  @override
  void onInit() {
    super.onInit();
    episodesInShowProvider.getEpisodes().then(
      (response) {
        if (kDebugMode) {
          print('getEpisodes.status: ${response.status.code}');
          print('getEpisodes.statusText: ${response.statusText}');
          print('getEpisodes.hasError: ${response.hasError}');
          print('getEpisodes.request: ${response.request}');
          print('getEpisodes.isOk: ${response.isOk}');
        }
        if (response.hasError) {
          onError(response.statusText);
          response.statusText;
        } else {
          episodes = response.body;
          // episodes?.sort((a,b)=>a.number);
          seasonsAndEpisodes =  groupBy(episodes!.map((e) => e), (p0) => p0.season);
          change(episodes!, status: RxStatus.success());
        }
      },
    ).catchError(onError);

  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to load Episodes', message: '$err');
    change([], status: RxStatus.error(err.toString()));
  }
}
