import 'package:flutter/material.dart';
import '../models/index.dart';
import '../widgets/index.dart';

/// Book detail screen
class BookDetailScreen extends StatefulWidget {
  final int bookId;

  const BookDetailScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Book? book;
  final cart = Cart();
  bool isInCart = false;

  @override
  void initState() {
    super.initState();
    book = BookData.getBookById(widget.bookId);
    isInCart = cart.containsBook(widget.bookId);
  }

  void _addToCart() {
    if (book != null) {
      cart.addItem(book!);
      setState(() {
        isInCart = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kitap sepete eklendi'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _contactSeller() {
    if (book != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Satıcı İletişim'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ad: ${book!.sellerName}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                'Telefon: ${book!.sellerPhone}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Text(
                'Satıcı ile iletişime geçebilirsiniz.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kapat'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kitap Bulunamadı'),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(
          child: Text('İstenilen kitap bulunamadı'),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            AppHeader(
              title: 'Kitap Detayı',
              showBackButton: true,
            ),

            // Book Image
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey[200],
              child: Image.network(
                book!.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.book,
                      size: 100,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book!.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Yazar: ${book!.author}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '₺${book!.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Condition Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getConditionColor(book!.condition),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Durum: ${book!.condition}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'Açıklama',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book!.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Book Details
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _DetailRow('Sayfa Sayısı', '${book!.pages}'),
                        const Divider(),
                        _DetailRow('ISBN', book!.isbn),
                        const Divider(),
                        _DetailRow('Kategori', book!.category),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Seller Information
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Satıcı Bilgisi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Ad: ${book!.sellerName}'),
                        const SizedBox(height: 4),
                        Text('Telefon: ${book!.sellerPhone}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _contactSeller,
                          icon: const Icon(Icons.phone),
                          label: const Text('Satıcı ile İletişim'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: isInCart ? null : _addToCart,
                          icon: Icon(
                            isInCart ? Icons.check : Icons.shopping_cart,
                          ),
                          label: Text(
                            isInCart ? 'Sepette' : 'Sepete Ekle',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isInCart ? Colors.grey : Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.blue;
      case 'fair':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

/// Detail row widget
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
