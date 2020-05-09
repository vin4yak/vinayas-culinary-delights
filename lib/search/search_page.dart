import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart';
import 'package:vinayas_culinary_delights/domain/post.dart';
import 'package:vinayas_culinary_delights/util/post_web_view.dart';
import 'package:vinayas_culinary_delights/util/service_gateway.dart';
import 'package:vinayas_culinary_delights/util/text_util.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchBar<Post>(
            searchBarStyle: SearchBarStyle(
              borderRadius: BorderRadius.circular(7.0),
              backgroundColor: Colors.white30,
              padding: EdgeInsets.all(2),
            ),
            minimumChars: 3,
            icon: Padding(
                padding: EdgeInsets.only(left: 7),
                child: FaIcon(FontAwesomeIcons.search)
            ),
            debounceDuration: Duration(milliseconds: 1000),
            hintText: 'Type Here...',
            textStyle: TextStyle(
              fontWeight: FontWeight.normal
            ),
            cancellationWidget: Text('Clear'),
            onSearch: search,
            placeHolder: Text('Find Amazing Recipes & More By Using Above Search Box!',
                style: TextStyle(fontSize: 15)
            ),
            emptyWidget: Text('No matching recipes found. Try changing your search.',
                style: TextStyle(fontSize: 16)),
            onItemFound: (Post post, int index) {
              return new InkWell(
                  child: Card(
                      child: ListTile(
                        title: Text(
                            TextUtil.unescapedText(post.title.rendered)
                        ),
                        subtitle: Text(
                            TextUtil.unescapedText(
                                parse(post.excerpt.rendered).body.text
                                .substring(0, 100) +  '...')
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => PostWebView(
                                  title: TextUtil.unescapedText(post.title.rendered),
                                  url: post.link
                              )
                          ));
                        },
                      )
                  ));
              },
          ),
        ),
      ),
    );
  }

  Future<List<Post>> search(String searchText) async {
    var posts = List<Post>();

    await ServiceGateway.searchPosts(searchText).then((response) {
      Iterable list = json.decode(response);
      posts = list.map((model) => Post.fromJson(model)).toList();
    });

    return posts;
  }

}
