import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:vinayas_culinary_delights/category/category_page.dart';
import 'package:vinayas_culinary_delights/domain/post.dart';
import 'package:vinayas_culinary_delights/util/service_gateway.dart';
import 'package:vinayas_culinary_delights/util/text_util.dart';

class RecentPostsPage extends StatefulWidget {
  @override
  createState() => RecentPostScreenState();

}

class RecentPostScreenState extends State {
  var posts = List<Post>();

  _getRecentPosts() {
    ServiceGateway.getRecentPosts().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        posts = list.map((model) => Post.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getRecentPosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: posts.length, itemBuilder: (context, index) {
      return Card(
          child: ListTile(
              title: Text(TextUtil.unescapedText(posts[index].title.rendered),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              //subtitle: Text(parse(posts[index].excerpt.rendered).body.text), //Switch in case of excerpt
              subtitle: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(image: CachedNetworkImageProvider(posts[index].featuredImage + '&resize=350%2C150')),
              ),
              trailing: Icon(Icons.open_in_new),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PostWebView(
                        title: TextUtil.unescapedText(posts[index].title.rendered),
                        url: posts[index].link
                    )
                ));
              }
          )
      );
    });
  }
}
