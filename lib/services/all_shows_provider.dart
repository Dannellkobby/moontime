/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:get/get.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/constants.dart';

class AllSeriesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = Show.listFromJson;
    httpClient.maxAuthRetries = 3;
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<List<Show>?> loadMoreShows(int currentPage) =>
      get<List<Show>>('/shows?page=$currentPage')
          .then((value) => Future.value(value.body));
}
