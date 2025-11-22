class MovieModel {
  final  int id;
  final String title;
  final String image;
  final double rating;
  
  MovieModel({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? 'No Title',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      id: json['id'],
    );
  }
}
