class BookNote {
  final int? id;
  final int bookId;
  final String note;
  final List<String> tag;

  BookNote({
    this.id,
    required this.bookId,
    required this.note,
    required this.tag,
  });

  factory BookNote.fromJson(Map<String, dynamic> json) {
    return BookNote(
      id: json['id'],
      bookId: json['bookId'],
      note: json['note'],
      tag: List<String>.from(json['tag']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      'note': note,
      'tag': tag,
    };
  }

  BookNote copyWith({
    int? id,
    int? bookId,
    String? note,
    List<String>? tag,
  }) {
    return BookNote(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      note: note ?? this.note,
      tag: tag ?? this.tag,
    );
  }
}
