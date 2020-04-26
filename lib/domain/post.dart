class Post {

  int id;
  String date;
  String slug;
  String link;
  Title title;
  Excerpt excerpt;
  String featuredImage;

  Post (int id, String date, String slug, String link, Title title,
      Excerpt excerpt, String jetpack_featured_media_url) {
    this.id = id;
    this.date = slug;
    this.slug = slug;
    this.link = link;
    this.title = title;
    this.excerpt = excerpt;
    this.featuredImage = jetpack_featured_media_url;
  }

  Post.fromJson(Map json)
      : id = json['id'],
        date = json['date'],
        slug = json['slug'],
        link = json['link'],
        title = Title.fromJson(json['title']),
        excerpt = Excerpt.fromJson(json['excerpt']),
        featuredImage = json['jetpack_featured_media_url'];

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
