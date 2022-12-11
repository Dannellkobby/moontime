import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/constants.dart';

class CastInEpisodeProvider extends GetConnect{
  final int episodeID;

  CastInEpisodeProvider({required this.episodeID});
  @override
  void onInit() {
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.defaultDecoder = Cast.listFromJson;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response<List<Cast>>> getEpisodeCast() => get<List<Cast>>('/episodes/$episodeID/guestcast');

}