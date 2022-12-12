import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/constants.dart';

class AiringEpisodesProvider extends GetConnect{


  @override
  void onInit() {
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.defaultDecoder = Episode.listFromJson;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response<List<Episode>>> getEpisodes() => get<List<Episode>>('/schedule');

}