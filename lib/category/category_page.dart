import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../domain/post.dart';
import '../util/service_gateway.dart';

class CategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryPage({Key key, this.categoryId, this.categoryName}) : super(key: key);
  @override
  createState() => CategoryScreenState(categoryId, categoryName);
}

class CategoryScreenState extends State {
  final int categoryId;
  final String categoryName;

  CategoryScreenState(this.categoryId, this.categoryName);

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
              return new InkWell(
                  child: Card(
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
                  ));
            })
    );
  }
}

void navigateToRecipesPage(BuildContext context, int categoryId, String categoryName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(categoryId: categoryId, categoryName: categoryName,)));
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
