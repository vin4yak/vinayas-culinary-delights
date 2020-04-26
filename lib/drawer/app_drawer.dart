import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text('Vinaya Prabhu'),
              accountEmail: Text('vinayasculinarydelights.com'),
              currentAccountPicture: new CircleAvatar(
                //child: new Image.asset('assets/vinaya.jpg')
                backgroundImage: new NetworkImage('http://vinayasculinarydelights.com/wp-content/uploads/2017/09/IMG_20170308_214839-01-01-01-02-01-01-01-267x300.jpg'),
              ),
            ),
            ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text('About the author'),
                onTap: () {
                  launch('http://vinayasculinarydelights.com/about-me/');
                }
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('About the app'),
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('Review app on Pay Store'),
            ),
          ],
        )
    );
  }
}
