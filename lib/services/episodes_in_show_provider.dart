import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/constants.dart';

class EpisodesInShowProvider extends GetConnect {
  final int showID;

  EpisodesInShowProvider({required this.showID});

  @override
  void onInit() {
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.defaultDecoder = Episode.listFromJson;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response<List<Episode>>> getEpisodes() =>
      get<List<Episode>>('/shows/$showID/episodes');
}
