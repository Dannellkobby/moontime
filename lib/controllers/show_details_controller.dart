/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/widgets.dart';
import "package:collection/collection.dart";
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

class ShowDetailsController extends GetxController
    with StateMixin<Tuple2<List<Cast>?, List<Episode>?>> {
  final RxString showID = RxString('');
  List<Episode>? episodes;
  Map<int, List<Episode>>? seasonsAndEpisodes;
  List<Cast>? castInShow;
  final client = http.Client();

  @override
  void onReady() async {
    ever(showID, fetchShowDetails);
    super.onReady();
    showID.refresh();
  }

  Future<void> fetchShowDetails(String showID) async {
    castInShow = await getCastInShow(showID);
    episodes = await getEpisodes(showID);
    seasonsAndEpisodes = groupBy(episodes!.map((e) => e), (p0) => p0.season);
    change(Tuple2(castInShow, episodes), status: RxStatus.success());
  }

  onError(err) {
    if (kDebugMode) {
      print('getShowDetails.error $err');
      toastError(title: 'Failed to load Show details', message: '$err');
    }
    change(null, status: RxStatus.error(err.toString()));
  }

  Future<List<Cast>> getCastInShow(id) {
    return client
        .get(Uri.https(kTVMazeAuthority, '/shows/$id/cast', {}))
        .then((response) {
      return Cast.listFromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }).catchError(onError);
  }

  Future<List<Episode>> getEpisodes(id) {
    return client
        .get(Uri.https(kTVMazeAuthority, '/shows/$id/episodes', {}))
        .then((response) {
      return Episode.listFromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }).catchError(onError);
  }

  @override
  void onClose() {
    client.close();
    super.onClose();
  }
}
