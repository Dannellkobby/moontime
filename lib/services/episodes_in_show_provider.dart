import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/constants.dart';

class EpisodesInShowProvider extends GetConnect{
final int showID;

  EpisodesInShowProvider(this.showID);

  @override
  void onInit() {
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.defaultDecoder = Episode.listFromJson;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
    print('EpisodesInShowProvider.getEpisodes ${httpClient.baseUrl}/shows/$showID/episodes');
  }

  Future<Response<List<Episode>>> getEpisodes() => get<List<Episode>>('/shows/$showID/episodes')
      ;

}