import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vinayas_culinary_delights/domain/food_art.dart';
import 'package:vinayas_culinary_delights/util/service_gateway.dart';

class FoodArtPage extends StatefulWidget {

  @override
  _FoodArtPageState createState() => _FoodArtPageState();

}

class _FoodArtPageState extends State {

  var foodArt = List<FoodArt>();

  @override
  void initState() {
    super.initState();
    _fetchFoodArt();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _fetchFoodArt() {
    ServiceGateway.getAllFoodArt().then((response){
      setState(() {
        Iterable list = json.decode(response);
        foodArt = list.map((model) => FoodArt.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: foodArt.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0
      ),
      itemBuilder: (BuildContext context, int index) {
        return new InkWell(
          child: Hero(
                  tag: foodArt[index].title,
                  child: CachedNetworkImage(
                    imageUrl: foodArt[index].imageUrl,
                    fit: BoxFit.cover,
                  )
              ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return FoodArtDetailScreen(
                imageUrl: foodArt[index].imageUrl,
                title: foodArt[index].title,
              );
            }));
          },
        );
      },
    );
  }

}

class FoodArtDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;

  FoodArtDetailScreen(
      {
        Key key,
        @required this.imageUrl,
        @required this.title
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: title,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 1.5,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

}
