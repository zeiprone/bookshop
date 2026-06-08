/// Book model class for second-hand book buy-sell application
class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final double price;
  final String condition; // 'Excellent', 'Good', 'Fair'
  final String imageUrl;
  final String description;
  final int pages;
  final String isbn;
  final String sellerName;
  final String sellerPhone;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.price,
    required this.condition,
    required this.imageUrl,
    required this.description,
    required this.pages,
    required this.isbn,
    required this.sellerName,
    required this.sellerPhone,
  });

  /// Convert JSON to Book object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      author: json['author'] ?? 'Unknown',
      category: json['category'] ?? 'Other',
      price: (json['price'] ?? 0).toDouble(),
      condition: json['condition'] ?? 'Good',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      pages: json['pages'] ?? 0,
      isbn: json['isbn'] ?? '',
      sellerName: json['sellerName'] ?? '',
      sellerPhone: json['sellerPhone'] ?? '',
    );
  }

  /// Convert Book object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'price': price,
      'condition': condition,
      'imageUrl': imageUrl,
      'description': description,
      'pages': pages,
      'isbn': isbn,
      'sellerName': sellerName,
      'sellerPhone': sellerPhone,
    };
  }
}
