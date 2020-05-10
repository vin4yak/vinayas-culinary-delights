import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:vinayas_culinary_delights/util/cache_manager.dart';

const baseUrl = 'https://vinayasculinarydelights.com/wp-json/wp/v2';

class ServiceGateway {

  static Future getCategories() async {
    var url = baseUrl + '/categories?per_page=100';
    var response = await CustomCacheManager().getSingleFile(url);
    return response.readAsString();
  }

  static Future getPosts(int categoryId) async {
    var url = baseUrl
        + '/posts?categories='
        + categoryId.toString()
        + '&per_page=100';

    var response = await CustomCacheManager().getSingleFile(url);
    return response.readAsString();
  }

  static Future getRecentPosts() async {
    var url = baseUrl + '/posts?per_page=15';
    var response = await CustomCacheManager().getSingleFile(url);
    return response.readAsString();
  }

  static Future searchPosts(String searchText) async {
    var url = baseUrl + '/posts?search=$searchText&per_page=20';
    var response = await CustomCacheManager().getSingleFile(url);
    return response.readAsString();
  }

  static Future getAllFoodArt() async {
    var url = 'https://vinayasculinarydelights.com/food_art.json';
    var response = await CustomCacheManager().getSingleFile(url);
    return response.readAsString();
  }

}
