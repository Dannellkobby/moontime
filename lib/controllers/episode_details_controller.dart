import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:http/http.dart' as http;

class EpisodeDetailsController extends GetxController
    with StateMixin<List<Cast>?> {
  List<Cast>? guestCast;
  final RxString episodeID = RxString('');
  final client = http.Client();

  EpisodeDetailsController();

  @override
  void onReady() async {
    ever(episodeID, fetchEpisodeDetails);
    super.onReady();
    episodeID.refresh();
  }

  Future<void> fetchEpisodeDetails(String episodeID) async {
    guestCast = await getCastInEpisode(episodeID);
    change(guestCast, status: RxStatus.success());
  }

  onError(err) {
    if (kDebugMode) print('getCastInEpisode.error $err');
    toastError(title: 'Failed to load Cast', message: '$err');
    change(null, status: RxStatus.error(err.toString()));
  }

  Future<List<Cast>> getCastInEpisode(id) {
    return client
        .get(Uri.https(kTVMazeAuthority, '/episodes/$id/guestcast', {}))
        .then((response) {
      return Cast.listFromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }).catchError(onError);
  }

  @override
  void onClose() {
    client.close();
    super.onClose();
  }
}
