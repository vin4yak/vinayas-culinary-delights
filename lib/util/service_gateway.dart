import 'package:http/http.dart' as http;
import 'dart:async';

const baseUrl = 'https://vinayasculinarydelights.com/wp-json/wp/v2';

class ServiceGateway {

  static Future getCategories() {
    var url = baseUrl + '/categories?per_page=50';
    return http.get(url);
  }

  static Future getPosts(int categoryId) {
    var url = baseUrl + '/posts?categories=' + categoryId.toString();
    return http.get(url);
  }

}
