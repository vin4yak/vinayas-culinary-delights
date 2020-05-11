import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinayas_culinary_delights/domain/post.dart';
import 'package:vinayas_culinary_delights/util/post_web_view.dart';
import 'package:vinayas_culinary_delights/util/progress_bar.dart';
import 'package:vinayas_culinary_delights/util/service_gateway.dart';
import 'package:vinayas_culinary_delights/util/text_util.dart';

class RecentPostsPage extends StatefulWidget {
  @override
  createState() => RecentPostScreenState();

}

class RecentPostScreenState extends State<RecentPostsPage> {
  bool isInProgress = true;
  var posts = List<Post>();

  _getRecentPosts() {
    ServiceGateway.getRecentPosts().then((response){
      setState(() {
        Iterable list = json.decode(response);
        posts = list.map((model) => Post.fromJson(model)).toList();
        isInProgress = false;
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
    return ProgressBar(
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                    title: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            TextUtil.unescapedText(posts[index].title.rendered),
                            style: TextStyle(fontWeight: FontWeight.bold)
                        )
                    ),
                    //subtitle: Text(parse(posts[index].excerpt.rendered).body.text), //Switch in case of excerpt
                    subtitle: Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image(
                                  image: CachedNetworkImageProvider(posts[index].featuredImage + '&resize=350%2C150')
                              ),
                            )
                        )
                    ),
                    trailing: Icon(Icons.open_in_new),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => PostWebView(
                              title: TextUtil.unescapedText(posts[index].title.rendered),
                              url: posts[index].link
                          )
                      ));
                    })
            );
          }),
      inAsyncCall: isInProgress,
      opacity: 0.5,
    );
  }
}
