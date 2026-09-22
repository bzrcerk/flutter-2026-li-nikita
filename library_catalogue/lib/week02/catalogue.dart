
import 'package:library_catalogue/week02/models.dart';

class Library {
  final List<LibraryItem> items;
  late final DateTime openedAt;
  String? _cachedReport;

  Library ({
    required this.items,
  });

  void addItem(LibraryItem item) {
    items.add(item);
  }

  Book? findByTitle(String title) {
    for (final item in items) {
      if (item is Book && item.title == title) {
        return item;
      }
    }

    return null;
  }

  String countryOf (String title) {
    return findByTitle(title)?.author.country ?? 'Unknown';
  }

  void open() {
    openedAt = DateTime.now();
  }

  String? buildReport() {
    final report =  _cachedReport ?? 'Library contains ${items.length} items.';
    _cachedReport ??= report;
    return _cachedReport;
  }

  List<String> get titles =>
      items.map((item) => item.title).toList();

  List<Book> get booksAfter2010 =>
      items.whereType<Book>().where((book) => book.year > 2010).toList();

  double get averagePageCount => items.whereType<Book>().isEmpty
      ? 0
      : items
      .whereType<Book>()
      .fold<int>(0, (sum, book) => sum + book.pages) /
      items.whereType<Book>().length;

  Map<String, int> get booksPerAuthor =>
      items.whereType<Book>().fold<Map<String, int>>(
        {},
            (counts, book) => {
          ...counts,
          book.author.name: (counts[book.author.name] ?? 0) + 1,
        },
      );

  Set<String> get authorNames =>
      items.whereType<Book>().map((book) => book.author.name).toSet();

  Set<Genre> get genres =>
      items.whereType<Book>().map((book) => book.genre).toSet();

  List<String> get displayList => [
    'CATALOGUE',
    for (final book in items.whereType<Book>())
      '${book.title} (${book.year})',
    ...authorNames,
    if (items.whereType<Book>().any((book) => book.pages == 0))
      '(incomplete data)',
  ];
}