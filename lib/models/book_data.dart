import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'book.dart';

/// Book data loaded from assets/data/books.json (JSON simulation)
class BookData {
  static List<Book> _books = [];

  /// Load and parse books.json into Book objects using Book.fromJson.
  /// Must be awaited once (e.g. in main()) before using the getters below.
  static Future<void> loadBooks() async {
    final jsonString = await rootBundle.loadString('assets/data/books.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _books = jsonList.map((item) => Book.fromJson(item)).toList();
  }

  static List<Book> getAllBooks() {
    return _books;
  }

  static List<String> getCategories() {
    final categories = <String>{};
    for (var book in _books) {
      categories.add(book.category);
    }
    return ['Tümü', ...categories];
  }

  static List<Book> getBooksByCategory(String category) {
    if (category == 'Tümü') {
      return getAllBooks();
    }
    return _books.where((book) => book.category == category).toList();
  }

  static Book? getBookById(int id) {
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Basit metin arama: başlık veya yazara göre filtreler.
  static List<Book> searchBooks(String query, {String category = 'Tümü'}) {
    final base = getBooksByCategory(category);
    if (query.trim().isEmpty) return base;
    final lowerQuery = query.trim().toLowerCase();
    return base.where((book) {
      return book.title.toLowerCase().contains(lowerQuery) ||
          book.author.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
