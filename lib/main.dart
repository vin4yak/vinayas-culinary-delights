import 'package:flutter/material.dart';
import 'package:vinayas_culinary_delights/recent/recent_posts.dart';

import 'category/category_page.dart';
import 'drawer/app_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal
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