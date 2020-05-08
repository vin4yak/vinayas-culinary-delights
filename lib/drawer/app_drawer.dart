import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> appInfo =
    {
      'appMarket': Platform.isAndroid? 'Play Store' : 'App Store',
      'platform': Platform.isAndroid? 'Android' : 'iOS'
    };
    var authorAvatar = 'https://vinayasculinarydelights.com/images/vinaya.jpg';

    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text('Vinaya Prabhu'),
              accountEmail: Text('vinayasculinarydelights.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(authorAvatar),
              ),
            ),
            ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text('About the author'),
                onTap: () {
                  launch('https://vinayasculinarydelights.com/about-me/');
                }
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('About the app'),
                onTap: () {
                  _aboutAppAlert(context, appInfo);
                }
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('Review app on ' + appInfo['appMarket']),
                onTap: () {
                  LaunchReview.launch();
                }
            ),
          ],
        )
    );
  }
}

Future<void> _aboutAppAlert(BuildContext context, Map<String, dynamic> appInfo) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
        title: Text('Culinary Delights For ' + appInfo['platform']),
        content: Text('Author: Vinaya Prabhu \n'
            'Developer: Vinayak Prabhu\n'
            'version: 1.0.1\n\n'
            'vinayasculinarydelights.com'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    barrierDismissible: true
  );
}
