import 'package:flutter/material.dart';
import '../models/index.dart';
import '../widgets/index.dart';

/// Shopping cart screen
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cart = Cart();

  void _updateQuantity(int bookId, int newQuantity) {
    setState(() {
      cart.updateQuantity(bookId, newQuantity);
    });
  }

  void _removeItem(int bookId) {
    setState(() {
      cart.removeItem(bookId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ürün sepetten kaldırıldı'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _checkout() {
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
          'Satın Alma Talebi',
          style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Toplam: ₺${cart.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A3324),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bu işlem bir satın alma talebi simülasyonudur.\n\nKitapları teslim almak ve ödeme yapmak için ilgili satıcılarla doğrudan iletişime geçiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontFamily: 'sans-serif', color: Color(0xFF6E675F)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'İptal',
              style: TextStyle(color: Color(0xFF6E675F), fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cart.clear();
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF1C1A17),
                  content: const Text(
                    'Talebiniz satıcılara iletildi',
                    style: TextStyle(
                      color: Color(0xFFFAF7F0),
                      fontFamily: 'serif',
                      fontSize: 14,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8A3324),
              foregroundColor: const Color(0xFFFAF7F0),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 0,
            ),
            child: const Text('TALEBİ GÖNDER'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = cart.items;

    return Scaffold(
      body: Column(
        children: [
          // Header
          const AppHeader(
            title: 'Sepetim',
            showBackButton: true,
          ),

          // Cart Items
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Color(0xFFC4BDB0),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Sepetiniz boş görünüyor.',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'serif',
                            color: Color(0xFF6E675F),
                          ),
                        ),
                        const SizedBox(height: 24),
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF1C1A17), width: 1.5),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            foregroundColor: const Color(0xFF1C1A17),
                          ),
                          child: const Text(
                            'KİTAPLARA DÖN',
                            style: TextStyle(
                              fontFamily: 'sans-serif',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final cartItem = items[index];
                      final book = cartItem.book;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF7F0),
                          border: Border.all(
                            color: const Color(0xFFE5DFD3),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Book Image
                            Container(
                              width: 80,
                              height: 110,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4F1EA),
                                border: Border(
                                  right: BorderSide(color: Color(0xFFE5DFD3), width: 1),
                                ),
                              ),
                              child: Image.asset(
                                book.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.menu_book_sharp,
                                    size: 32,
                                    color: Color(0xFFC4BDB0),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Book Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'serif',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: Color(0xFF1C1A17),
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    book.author,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'sans-serif',
                                      color: Color(0xFF6E675F),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '₺${book.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontFamily: 'serif',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF8A3324),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Quantity and Remove
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _updateQuantity(
                                          book.id,
                                          cartItem.quantity - 1,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF4F1EA),
                                            border: Border.all(
                                              color: const Color(0xFFE5DFD3),
                                              width: 1,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 14,
                                            color: Color(0xFF1C1A17),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          '${cartItem.quantity}',
                                          style: const TextStyle(
                                            fontFamily: 'monospace',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _updateQuantity(
                                          book.id,
                                          cartItem.quantity + 1,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1C1A17),
                                            border: Border.all(
                                              color: const Color(0xFF1C1A17),
                                              width: 1,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 14,
                                            color: Color(0xFFFAF7F0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => _removeItem(book.id),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFC4BDB0),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text(
                                      'SİL',
                                      style: TextStyle(
                                        fontFamily: 'sans-serif',
                                        fontSize: 9,
                                        color: Color(0xFF6E675F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Bottom Summary and Checkout
          if (items.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFAF7F0),
                border: Border(
                  top: BorderSide(color: Color(0xFF1C1A17), width: 1.5),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOPLAM TUTAR',
                        style: TextStyle(
                          fontFamily: 'sans-serif',
                          fontSize: 11,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6E675F),
                        ),
                      ),
                      Text(
                        '₺${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF8A3324),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _checkout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C1A17),
                        foregroundColor: const Color(0xFFFAF7F0),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                      ),
                      child: const Text(
                        'SATIN ALMA TALEBİ GÖNDER',
                        style: TextStyle(
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
            ),
        ],
      ),
    );
  }
}
