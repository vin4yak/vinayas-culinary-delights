import 'dart:convert';

import 'package:flutter/material.dart';
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
        return Container(
          child: Image.network(foodArt[index].imageUrl,
          fit: BoxFit.cover,)
        );
      },
    );
  }

}
