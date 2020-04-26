import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:vinayas_culinary_delights/util/cache_manager.dart';

const baseUrl = 'https://vinayasculinarydelights.com/wp-json/wp/v2';

class ServiceGateway {

  static Future getCategories() async {
    var url = baseUrl + '/categories?per_page=50';
    var file = await CustomCacheManager().getSingleFile(url);
    return file.readAsString();
  }

  static Future getPosts(int categoryId) {
    var url = baseUrl + '/posts?categories=' + categoryId.toString();
    return http.get(url);
  }

  static Future getRecentPosts() {
    var url = baseUrl + '/posts?per_page=10';
    return http.get(url);
  }

}
