class Book {
  final int? id;
  final String title;
  final int reviewStar;
  final double price;
  final String imageUrl;
  final bool isFav;

  Book({
    this.id,
    required this.title,
    required this.reviewStar,
    required this.price,
    required this.imageUrl,
    required this.isFav,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      reviewStar: json['reviewStar'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      isFav: json['isFav'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'reviewStar': reviewStar,
      'price': price,
      'imageUrl': imageUrl,
      'isFav': isFav,
    };
  }

  Book copyWith({
    int? id,
    String? title,
    int? reviewStar,
    double? price,
    String? imageUrl,
    bool? isFav,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      reviewStar: reviewStar ?? this.reviewStar,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFav: isFav ?? this.isFav,
    );
  }
}
