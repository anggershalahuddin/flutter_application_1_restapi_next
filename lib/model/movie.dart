class Movie {
  int id;
  String title;
  String year;
  double rating;
  String thumbnail;
  String images;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.thumbnail,
    required this.images,
  });

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
      id: map['id'],
      title: map['title'],
      year: map['year'],
      rating: map['rating'],
      thumbnail: map['thumbnail'],
      images: map['images']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'year': year,
        'rating': rating,
        'thumbnail': thumbnail,
        'images': images
      };
}
