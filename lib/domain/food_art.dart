class FoodArt {

  int id;
  String title;
  String imageUrl;

  FoodArt(this.id, this.title, this.imageUrl);

  FoodArt.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['imageUrl'];
}
