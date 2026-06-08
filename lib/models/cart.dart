import 'package:flutter/foundation.dart';
import 'book.dart';

/// Cart item class
class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });

  double get subtotal => book.price * quantity;
}

/// Shopping cart model for the application
class Cart {
  static final Cart _instance = Cart._internal();
  final List<CartItem> _items = [];

  factory Cart() {
    return _instance;
  }

  Cart._internal();

  /// Get all items in cart
  List<CartItem> get items => _items;

  /// Get total number of items
  int get itemCount => _items.length;

  /// Get total price
  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.subtotal);
  }

  /// Add item to cart
  void addItem(Book book) {
    try {
      final existingIndex = _items.indexWhere((item) => item.book.id == book.id);
      if (existingIndex >= 0) {
        _items[existingIndex].quantity++;
      } else {
        _items.add(CartItem(book: book));
      }
    } catch (e) {
      // Handle error silently for production
      debugPrint('Error adding item to cart: $e');
    }
  }

  /// Remove item from cart
  void removeItem(int bookId) {
    _items.removeWhere((item) => item.book.id == bookId);
  }

  /// Update item quantity
  void updateQuantity(int bookId, int quantity) {
    final item = _items.firstWhere(
      (item) => item.book.id == bookId,
      orElse: () => CartItem(book: Book(
        id: 0,
        title: '',
        author: '',
        category: '',
        price: 0,
        condition: '',
        imageUrl: '',
        description: '',
        pages: 0,
        isbn: '',
        sellerName: '',
        sellerPhone: '',
      )),
    );
    if (item.book.id != 0) {
      item.quantity = quantity;
      if (item.quantity <= 0) {
        removeItem(bookId);
      }
    }
  }

  /// Clear cart
  void clear() {
    _items.clear();
  }

  /// Check if item exists in cart
  bool containsBook(int bookId) {
    return _items.any((item) => item.book.id == bookId);
  }
}
