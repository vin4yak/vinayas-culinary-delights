import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinayas_culinary_delights/util/app_info.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authorAvatar = 'https://vinayasculinarydelights.com/images/vinaya.jpg';

    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text('Vinaya Prabhu', style: TextStyle(fontSize: 16)),
              accountEmail: Text('vinayasculinarydelights.com', style: TextStyle(fontSize: 16)),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(authorAvatar),
              ),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.addressCard),
                title: Text('About the author', style: TextStyle(fontSize: 15)),
                onTap: () {
                  launch('https://vinayasculinarydelights.com/about-me/');
                }
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('About the app', style: TextStyle(fontSize: 15)),
                onTap: () {
                  _aboutAppAlert(context);
                }
            ),
            new Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.thumbsUp),
              title: Text('Review us on ' + AppInfo.fetch()['store'],
                  style: TextStyle(fontSize: 15)
              ),
                onTap: () {
                  LaunchReview.launch();
                }
            ),
          ],
        )
    );
  }
}

Future<void> _aboutAppAlert(BuildContext context) {
  String version;
  AppInfo.version().then((value) {
    version = value;
  });

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
        title: Text('Culinary Delights For ' + AppInfo.fetch()['platform']),
        content: Text('Author: Vinaya Prabhu \n'
            'Developer: Vinayak Prabhu\n'
            'version: $version\n\n'
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
