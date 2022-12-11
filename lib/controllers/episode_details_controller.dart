import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/services/cast_in_episode_provider.dart';
import 'package:moontime/services/cast_in_show_provider.dart';
import 'package:moontime/utilities/widgets.dart';
import 'package:tuple/tuple.dart';

class EpisodeDetailsController extends GetxController
    with StateMixin<Tuple2<List<Cast>?, List<Cast>?>> {
  final CastInShowProvider castInShowProvider;
  final CastInEpisodeProvider castInEpisodeProvider;
  List<Cast>? showCast;
  List<Cast>? guestCast;

  EpisodeDetailsController(
      {required this.castInShowProvider, required this.castInEpisodeProvider});

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
          castInEpisodeProvider.getEpisodeCast().then(
            (response) {
              if (response.hasError) {
                onError(response.statusText);
                response.statusText;
              } else {
                guestCast = response.body;
                change(Tuple2(showCast!, guestCast!),
                    status: RxStatus.success());
              }
            },
          ).catchError(onError);
        }
      },
    ).catchError(onError);
  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to load Cast', message: '$err');
    change(null, status: RxStatus.error(err.toString()));
  }
}
