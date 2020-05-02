import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinayas_culinary_delights/recent/recent_posts.dart';

import 'category/category_page.dart';
import 'domain/push_message.dart';
import 'drawer/app_drawer.dart';

void main() => runApp(CulinaryDelightsApp());

class CulinaryDelightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Recent Posts"),
                Tab(text: "Categories")
              ],
            ),
            title: Text("Vinaya's Culinary Delights"),
          ),
          body: TabBarView(
            children: [
              RecentPostsPage(),
              Categories()
            ],
          ),
        ),
      )
    );
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainPageWidget>{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<PushMessage> pushMessages = [];

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          final notification = message['notification'];

          setState(() {
            pushMessages.add(PushMessage(
              title: notification['title'],
              body: notification['body'],
            ));
          });
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        }
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true)
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabBarView(
      children: [
        RecentPostsPage(),
        Categories()
      ],
    );
  }
}
