/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/all_shows_provider.dart';
import 'package:moontime/services/airing_episodes_provider.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:tuple/tuple.dart';

class HomeController extends GetxController
    with StateMixin<Tuple2<List<Episode>?, List<Show>?>> {
  final AiringEpisodesProvider airingEpisodes;
  final AllSeriesProvider seriesProvider;
  List<Episode>? episodes;
  RxList<Show>? shows = RxList();
  static const int tvMazeMaxPageIndex = 262;
  final RxInt currentPage = RxInt(tvMazeMaxPageIndex);
  static const int pageSize = 250;

  final RxBool fetching = RxBool(false);

  HomeController({required this.airingEpisodes, required this.seriesProvider});

  @override
  void onReady() {
    super.onReady();
    airingEpisodes.getEpisodes().then(
      (response) {
        if (response.hasError) {
          onError(response.statusText);
          response.statusText;
        } else {
          episodes = response.body;
          change(Tuple2(episodes!, shows), status: RxStatus.success());
        }
      },
    );
    loadMoreShows();
  }

  loadMoreShows() async {
    if (fetching.isTrue) return;
    fetching.value = true;
    List? newList = await seriesProvider.loadMoreShows(currentPage.value);
    if (newList?.isEmpty ?? true) {
    } else {
      currentPage.value--;
      shows?.addAll(newList as List<Show>);
    }
    fetching.value = false;
  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to load Airing Episodes', message: '$err');
    change(null, status: RxStatus.error(err.toString()));
  }
}
