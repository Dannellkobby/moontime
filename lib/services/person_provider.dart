/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:get/get.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/constants.dart';

class PersonCastsProvider extends GetConnect{
  final int personID;

  PersonCastsProvider({required this.personID});
  @override
  void onInit() {
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.defaultDecoder = Show.listFromEmbeddedShowsJson;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response<List<Show>>> getPersonCasts() => get<List<Show>>('/people/$personID/castcredits?embed=show');

}