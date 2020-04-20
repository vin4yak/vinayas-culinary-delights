import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinayas_culinary_delights/category.dart';
import 'package:vinayas_culinary_delights/post.dart';
import 'package:vinayas_culinary_delights/service_gateway.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart';

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
        drawer: Drawer(
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
        ),
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

void navigateToRecipesPage(BuildContext context, int categoryId, String categoryName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(categoryId: categoryId, categoryName: categoryName,)));
}

class CategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryPage({Key key, this.categoryId, this.categoryName}) : super(key: key);
  @override
  createState() => _MyListScreenState(categoryId, categoryName);
}

class _MyListScreenState extends State {
  final int categoryId;
  final String categoryName;

  _MyListScreenState(this.categoryId, this.categoryName);

  var posts = List<Post>();

  _getCategories() {
    ServiceGateway.getPosts(categoryId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        posts = list.map((model) => Post.fromJson(model)).toList();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse ' + categoryName),
      ),
        body: ListView.builder(itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(posts[index].title.rendered,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(parse(posts[index].excerpt.rendered).body.text),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PostWebView(
                          title: posts[index].slug,
                          url: posts[index].link
                        )
                      ));
                  },
                ),
              );
            })
    );

  }
}

class PostWebView extends StatelessWidget {
  final String title;
  final String url;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  PostWebView({
    @required this.title,
    @required this.url
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title)
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }

}
