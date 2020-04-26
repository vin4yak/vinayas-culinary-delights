import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vinayas_culinary_delights/domain/category.dart';
import 'package:vinayas_culinary_delights/domain/post.dart';
import 'package:vinayas_culinary_delights/util/service_gateway.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart';

import 'category/category_page.dart';
import 'drawer/app_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Vinaya's Culinary Delights",
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Vinaya's Culinary Delights"),
        ),
        body: Categories()
      ),
    );
  }
}

class Categories extends StatefulWidget {
  @override
  createState() => MainScreenState();
}

class MainScreenState extends State {
  var categories = List<Category>();

  _getCategories() {
    ServiceGateway.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        categories = list.map((model) => Category.fromJson(model)).toList();

      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(categories[index].name),
              subtitle: Text(categories[index].description),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                navigateToRecipesPage(context, categories[index].id, categories[index].name);
              },
            ),
          );
        });
  }
}
