class Category {

  int id;
  String name;
  String link;
  String description;

  Category (int id, String name, String link, String description) {
    this.id = id;
    this.name = name;
    this.link = link;
    this.description = description;
  }

  Category.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        link = json['link'],
        description = json['description'];

  Map toJson() {
    return {'id': id, 'name': name, 'link': link, 'description': description};
  }

}