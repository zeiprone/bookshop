import 'package:flutter/material.dart';
import '../models/index.dart';
import '../widgets/index.dart';

/// Book detail screen
class BookDetailScreen extends StatefulWidget {
  final int bookId;

  const BookDetailScreen({super.key, required this.bookId});

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
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          content: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7F0),
              border: Border.all(color: const Color(0xFF1C1A17), width: 1.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SEPETİNİZE EKLENDİ',
                        style: TextStyle(
                          fontFamily: 'sans-serif',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Color(0xFF8A3324),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book!.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1C1A17),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    Navigator.pushNamed(context, '/cart').then((_) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF1C1A17),
                        width: 1.2,
                      ),
                      color: const Color(0xFF1C1A17),
                    ),
                    child: const Text(
                      'SEPETE GİT',
                      style: TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFAF7F0),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _contactSeller() {
    if (book != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFFAF7F0),
          surfaceTintColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Color(0xFF1C1A17), width: 2),
            right: BorderSide(color: Color(0xFF1C1A17), width: 2),
            top: BorderSide(color: Color(0xFF1C1A17), width: 0.5),
            left: BorderSide(color: Color(0xFF1C1A17), width: 0.5),
          ),
          title: const Text(
            'Satıcı İletişim',
            style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ad: ${book!.sellerName}',
                style: const TextStyle(
                  fontFamily: 'sans-serif',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1A17),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Telefon: ${book!.sellerPhone}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8A3324),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Satıcı ile doğrudan telefon üzerinden iletişime geçebilirsiniz.',
                style: TextStyle(fontSize: 11, color: Color(0xFF6E675F)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Kapat',
                style: TextStyle(
                  color: Color(0xFF1C1A17),
                  fontWeight: FontWeight.bold,
                ),
              ),
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
          title: const Text(
            'Kitap Bulunamadı',
            style: TextStyle(fontFamily: 'serif'),
          ),
          backgroundColor: const Color(0xFF8A3324),
          foregroundColor: const Color(0xFFFAF7F0),
        ),
        body: const Center(
          child: Text(
            'İstenilen kitap bulunamadı',
            style: TextStyle(fontFamily: 'serif'),
          ),
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
              showCartButton: true,
              cartItemCount: cart.itemCount,
              onCartPressed: () {
                Navigator.pushNamed(context, '/cart').then((_) {
                  setState(() {
                    isInCart = cart.containsBook(widget.bookId);
                  });
                });
              },
            ),

            // Book Image
            Container(
              width: double.infinity,
              height: 320,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5DFD3), width: 1.5),
                ),
                color: Color(0xFFF4F1EA),
              ),
              child: Image.asset(
                book!.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.menu_book_sharp,
                      size: 80,
                      color: Color(0xFFC4BDB0),
                    ),
                  );
                },
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
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
                                fontFamily: 'serif',
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1C1A17),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Yazar: ${book!.author}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'sans-serif',
                                color: Color(0xFF6E675F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '₺${book!.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF8A3324),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Condition Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7F0),
                      border: Border.all(
                        color: _getConditionBorderColor(book!.condition),
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      'DURUM: ${_getConditionTurkish(book!.condition)}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _getConditionBorderColor(book!.condition),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'KİTAP AÇIKLAMASI',
                    style: TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Color(0xFF1C1A17),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book!.description,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontSize: 15,
                      color: Color(0xFF2E2B2A),
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Book Details
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7F0),
                      border: Border.all(
                        color: const Color(0xFFE5DFD3),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        _DetailRow('Sayfa Sayısı', '${book!.pages}'),
                        const Divider(height: 1, color: Color(0xFFE5DFD3)),
                        _DetailRow('ISBN', book!.isbn),
                        const Divider(height: 1, color: Color(0xFFE5DFD3)),
                        _DetailRow('Kategori', book!.category),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Seller Information
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F1EA),
                      border: Border.all(
                        color: const Color(0xFFE5DFD3),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SATICI BİLGİLERİ',
                          style: TextStyle(
                            fontFamily: 'sans-serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 1.0,
                            color: Color(0xFF1C1A17),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adı Soyadı:',
                              style: TextStyle(
                                fontFamily: 'sans-serif',
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              book!.sellerName,
                              style: const TextStyle(
                                fontFamily: 'sans-serif',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Konum / İletişim:',
                              style: TextStyle(
                                fontFamily: 'sans-serif',
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              book!.sellerPhone,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF8A3324),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _contactSeller,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF1C1A17),
                              width: 1.5,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            foregroundColor: const Color(0xFF1C1A17),
                          ),
                          child: const Text(
                            'SATICIYLA GÖRÜŞ',
                            style: TextStyle(
                              fontFamily: 'sans-serif',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isInCart ? null : _addToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1C1A17),
                            disabledBackgroundColor: const Color(0xFFC4BDB0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            foregroundColor: const Color(0xFFFAF7F0),
                            elevation: 0,
                          ),
                          child: Text(
                            isInCart ? 'SEPETE EKLENDİ' : 'SEPETE EKLE',
                            style: const TextStyle(
                              fontFamily: 'sans-serif',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConditionBorderColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
        return const Color(0xFF3B6B4C);
      case 'good':
        return const Color(0xFF4A6B82);
      case 'fair':
        return const Color(0xFF9E653A);
      default:
        return const Color(0xFF6E675F);
    }
  }

  String _getConditionTurkish(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
        return 'ÇOK İYİ';
      case 'good':
        return 'İYİ';
      case 'fair':
        return 'YIPRANMIŞ';
      default:
        return condition.toUpperCase();
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'sans-serif',
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF6E675F),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Color(0xFF1C1A17),
            ),
          ),
        ],
      ),
    );
  }
}
