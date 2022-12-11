import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/episode.dart';
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
    print('api: $kTVMazeBaseUrl/people/$personID/castcredits?embed=show');
  }

  Future<Response<List<Show>>> getPersonCasts() => get<List<Show>>('/people/$personID/castcredits?embed=show');

}