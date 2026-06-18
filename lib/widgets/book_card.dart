import 'package:flutter/material.dart';
import '../models/index.dart';

/// Book card widget for displaying books in grid/list
class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F0),
          border: Border.all(
            color: const Color(0xFFE5DFD3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 160,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE5DFD3),
                    width: 1.5,
                  ),
                ),
                color: Color(0xFFF4F1EA),
              ),
              child: Image.asset(
                book.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.book_sharp,
                      size: 48,
                      color: Color(0xFFC4BDB0),
                    ),
                  );
                },
              ),
            ),
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'sans-serif',
                        color: Color(0xFF6E675F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F0),
                        border: Border.all(
                          color: _getConditionBorderColor(book.condition),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _getConditionTurkish(book.condition),
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'monospace',
                          color: _getConditionBorderColor(book.condition),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₺${book.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF8A3324),
                          ),
                        ),
                        if (onAddToCart != null)
                          GestureDetector(
                            onTap: onAddToCart,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF1C1A17),
                                  width: 1.2,
                                ),
                                color: const Color(0xFF1C1A17),
                              ),
                              child: const Text(
                                'EKLE',
                                style: TextStyle(
                                  color: Color(0xFFFAF7F0),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
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
        return const Color(0xFF3B6B4C); // deep sage green
      case 'good':
        return const Color(0xFF4A6B82); // muted slate blue
      case 'fair':
        return const Color(0xFF9E653A); // muted copper
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
