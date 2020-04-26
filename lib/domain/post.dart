class Post {

  int id;
  String date;
  String slug;
  String link;
  Title title;
  Excerpt excerpt;

  Post (int id, String date, String slug, String link, Title, title, Excerpt excerpt) {
    this.id = id;
    this.date = slug;
    this.slug = slug;
    this.link = link;
    this.title = title;
    this.excerpt = excerpt;
  }

  Post.fromJson(Map json)
      : id = json['id'],
        date = json['date'],
        slug = json['slug'],
        link = json['link'],
        title = Title.fromJson(json['title']),
        excerpt = Excerpt.fromJson(json['excerpt']);

  Map toJson() {
    return {'id': id, 'date': date, 'slug': slug, 'link': link};
  }

}

class Title {

  String rendered;

  Title({
    this.rendered
  });

  Title.fromJson(Map json) : rendered = json['rendered'];

}

class Excerpt {

  String rendered;

  Excerpt({
    this.rendered
  });

  Excerpt.fromJson(Map json) : rendered = json['rendered'];

}
