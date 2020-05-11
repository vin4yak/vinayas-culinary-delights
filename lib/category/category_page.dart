import 'dart:convert';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:vinayas_culinary_delights/domain/category.dart';
import 'package:vinayas_culinary_delights/util/admob_properties.dart';
import 'package:vinayas_culinary_delights/util/post_web_view.dart';
import 'package:vinayas_culinary_delights/util/progress_bar.dart';
import 'package:vinayas_culinary_delights/util/text_util.dart';

import '../domain/post.dart';
import '../util/service_gateway.dart';

class Categories extends StatefulWidget {
  @override
  createState() => MainScreenState();
}

class MainScreenState extends State<Categories> {
  var categories = List<Category>();

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: AdMobProperties.keywords,
    contentUrl: 'https://vinayasculinarydelights.com',
    nonPersonalizedAds: true,
    childDirected: false
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdMobProperties.bannerAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  _getCategories() {
    ServiceGateway.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(response);
        categories = list.map((model) => Category.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();

    FirebaseAdMob.instance.initialize(appId: AdMobProperties.appId);

    _bannerAd = createBannerAd()..load()..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(TextUtil.unescapedText(categories[index].name)),
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
  createState() => CategoryScreenState(categoryId, categoryName);
}

class CategoryScreenState extends State<CategoryPage> {
  bool isInProgress = true;
  final int categoryId;
  final String categoryName;

  CategoryScreenState(this.categoryId, this.categoryName);

  var posts = List<Post>();

  _getCategories() {
    ServiceGateway.getPosts(categoryId).then((response) {
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
        body: ProgressBar(
            child: ListView.builder(itemCount: posts.length,
                itemBuilder: (context, index) {
                  return new InkWell(
                      child: Card(
                        child: ListTile(
                          title: Text(TextUtil.unescapedText(posts[index].title.rendered),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(parse(posts[index].excerpt.rendered).body.text),
                          trailing: Icon(Icons.open_in_new),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => PostWebView(
                                    title: TextUtil.unescapedText(posts[index].title.rendered),
                                    url: posts[index].link
                                )
                            ));
                          },
                        ),
                      ));
                }),
          inAsyncCall: isInProgress,
          opacity: 0.5,
        )
    );
  }
}
