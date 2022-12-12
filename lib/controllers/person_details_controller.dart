import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/services/person_provider.dart';
import 'package:moontime/utilities/widgets.dart';

class PersonDetailsController extends GetxController with StateMixin<List<Show>?> {

  final PersonCastsProvider personProvider;
  List<Show>? shows;

  PersonDetailsController(
      {required this.personProvider});

  @override
  void onInit() {
    super.onInit();
    personProvider.getPersonCasts().then(
      (response) {
        if (response.hasError) {
          onError(response.statusText);
          response.statusText;
        } else {
          shows = response.body;
          change(shows!, status: RxStatus.success());
        }
      },
    );

  }

  onError(err) {
    if (kDebugMode) print('getEpisodes.error $err');
    toastError(title: 'Failed to load Shows', message: '$err');
    change([], status: RxStatus.error(err.toString()));
  }
}
