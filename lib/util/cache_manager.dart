import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class CustomCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static CustomCacheManager _instance;

  factory CustomCacheManager() {
    if (_instance == null) {
      _instance = new CustomCacheManager._();
    }
    return _instance;
  }

  CustomCacheManager._()
      : super(key,
      maxAgeCacheObject: Duration(hours: 3),
      maxNrOfCacheObjects: 20,
      fileFetcher: getData);

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }

  static Future<FileFetcherResponse> getData(String url,
      {Map<String, String> headers}) async {
    HttpFileFetcherResponse response;
    try {
      var res = await http.get(url, headers: headers);
      res.headers.addAll({'cache-control': 'private, max-age=120'});
      response = HttpFileFetcherResponse(res);
    } on SocketException {
      print('No internet connection');
    }
    return response;
  }

}
