import 'dart:io';

import 'package:package_info/package_info.dart';

class AppInfo {

  static Map<String, dynamic> fetch() {
    Map<String, dynamic> appInfo =
    {
      'store': Platform.isAndroid? 'Play Store' : 'App Store',
      'platform': Platform.isAndroid? 'Android' : 'iOS',
    };
    return appInfo;
  }

  static Future<String> version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

}
