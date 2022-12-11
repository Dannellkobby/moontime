import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/constants.dart';

class CastInShowProvider extends GetConnect{
  final int showID;

  CastInShowProvider({required this.showID});
  @override
  void onInit() {
    httpClient.baseUrl = kTVMazeBaseUrl;
    httpClient.defaultDecoder = Cast.listFromJson;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response<List<Cast>>> getShowCast() => get<List<Cast>>('/shows/$showID/cast');

}