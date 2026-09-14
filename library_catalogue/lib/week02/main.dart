import 'models.dart';
import 'catalogue.dart';
import 'shelf_state.dart';

void main() {
  final rawBooks = <Map<String, dynamic>>[
    {
      'title': 'Clean Code',
      'year': 2008,
      'pages': 464,
      'author': {
        'name': 'Robert C. Martin',
        'country': 'USA',
      },
      'genre': 'craft',
      'description': 'A book about writing clean code.',
    },
    {
      'title': 'Effective Dart',
      'year': 2015,
      'pages': 300,
      'author': {
        'name': 'Dart Team',
        'country': 'USA',
      },
      'genre': 'theory',
      'description': 'Guidelines for writing Dart code.',
    },
    {
      'title': 'Unknown Book',
      'year': 2022,
      'pages': 0,
      'author': {
        'name': 'Unknown Author',
      },
      'genre': 'unknown',
    },
  ];

  final library = Library(items:[]);

  final books = rawBooks.map(Book.fromJson).toList();

  for (final book in books) {
    library.addItem(book);
  }

  library.open();

  print('Titles: ${library.titles}');
  print('Books after 2010: ${library.booksAfter2010}');
  print('Average pages: ${library.averagePageCount}');
  print('Books per author: ${library.booksPerAuthor}');
  print('Authors: ${library.authorNames}');
  print('Genres: ${library.genres}');
  print('Country: ${library.countryOf('Clean Code')}');

  print('\nDisplay list:');
  print(library.displayList.join('\n'));

  final stats = statsOf(books);

  print('\nStats: $stats');
  print('Count: ${stats.count}');
  print('Average pages: ${stats.avgPages}');

  const emptyState = Empty();

  final readyState = Ready(books);

  const brokenState = Broken('Shelf sensor is unavailable');

  print('\n${describe(emptyState)}');
  print(describe(readyState));
  print(describe(brokenState));
}