abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({
    required this.title,
    required this.year
  });

  String describe();

  bool get isOld => year < 1985;
}

mixin Borrowable on LibraryItem{
  String borrowLabel() {
    return 'Borrow: $title';
  }
}

class Author {
  final String name;
  final String? country;

  const Author ({
    required this.name,
    this.country
  });

  @override
  String toString() {
    if (country == null) return name;
    return ("$name is author from $country");
  }
}

enum Genre {
  craft('Craft'),
  theory("Theory"),
  unknown('Unknown');

  final String label;

  const Genre(this.label);

  static Genre fromString(String? raw) {
    if (raw == null) {
      return Genre.unknown;
    }

    switch (raw.toLowerCase().trim()){
      case 'craft':
        return Genre.craft;
      case 'theory':
        return Genre.theory;
      default:
        return Genre.unknown;
    }
  }
}

class Ghost implements LibraryItem {
  @override
  final String title;

  @override
  final int year;

  const Ghost({
    required this.title,
    required this.year,
  });

  @override
  String describe() {
    return 'Ghost: $title';
  }

  @override
  bool get isOld => year < 1900;
}


class Book extends LibraryItem with Borrowable{
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description
  });

  const Book.missing()
    : pages = 0,
      author = const Author(name: 'Unknown'),
      genre = Genre.unknown,
      description = null,
      super(
          title: 'Unknown',
          year: 0,
      );


  factory Book.fromJson(Map<String, dynamic> json) {
    int parseInt(Object? value) {
      if (value is int) {
        return value;
      }
      if (value is num) {
        return value.toInt();
      }
      if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    Author parseAuthor(Object? value) {
      if (value is Map) {
        final name = value['name'];
        final country = value['country'];
        return Author(
          name: name is String ? name : 'Unknown',
          country: country is String ? country : null,
        );
      }
      if (value is String) {
        return Author(name: value);
      }
      return const Author(name: 'Unknown');
    }

    final titleValue = json['title'];
    final descriptionValue = json['description'];
    final genreValue = json['genre'];
    
    return Book(
        title: titleValue is String ? titleValue : "Unknown",
        year: parseInt(json['year']),
        pages: parseInt(json['pages']),
        author: parseAuthor(json['Author']),
        genre: Genre.fromString(
          genreValue is String ? genreValue : null
        ),
        description: descriptionValue is String ? descriptionValue : null
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description
}) {
    return Book(
        title: title ?? this.title,
        year: year ?? this.year,
        pages: pages ?? this.pages,
        author: author ?? this.author,
        genre: genre ?? this.genre,
        description: description ?? this.description
    );
  }

  @override
  String describe() {
    return 'This book is about ${description ?? 'No description.'} . Written by $author';
  }

  @override
  String toString() {
    return 'Book('
        'title: $title, '
        'year: $year, '
        'pages: $pages, '
        'author: $author, '
        'genre: ${genre.label}, '
        'description: $description'
        ')';
    }
  }

class Magazine extends LibraryItem {
  final String issue;

  const Magazine({
    required super.title,
    required super.year,
    required this.issue,
});

  @override
  String describe() {
    return 'The main issue of this magazine is $title';
  }
}
