import 'package:flutter/material.dart';
import '../models/index.dart';
import '../widgets/index.dart';

/// Home screen showing list of books
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cart = Cart();
  final _searchController = TextEditingController();
  List<Book> books = [];
  List<String> categories = [];
  String selectedCategory = 'Tümü';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() {
    books = BookData.getAllBooks();
    categories = BookData.getCategories();
    setState(() {});
  }

  void _applyFilters() {
    setState(() {
      books = BookData.searchBooks(searchQuery, category: selectedCategory);
    });
  }

  void _filterByCategory(String category) {
    selectedCategory = category;
    _applyFilters();
  }

  void _onSearchChanged(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void _addToCart(Book book) {
    cart.addItem(book);
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
                      book.title,
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
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          AppHeader(
            title: 'İkinci El Kitap',
            showCartButton: true,
            cartItemCount: cart.itemCount,
            onCartPressed: () {
              Navigator.pushNamed(context, '/cart').then((_) {
                setState(() {});
              });
            },
          ),

          // Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(fontFamily: 'sans-serif', fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Kitap veya yazar ara...',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF8A3324)),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                filled: true,
                fillColor: const Color(0xFFFAF7F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFFE5DFD3), width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFFE5DFD3), width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF8A3324), width: 1.5),
                ),
              ),
            ),
          ),

          // Category Filter
          SizedBox(
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _filterByCategory(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8A3324)
                            : const Color(0xFFFAF7F0),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF8A3324)
                              : const Color(0xFFE5DFD3),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFFAF7F0)
                                : const Color(0xFF1C1A17),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Books Grid
          Expanded(
            child: books.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.menu_book_sharp,
                          size: 48,
                          color: Color(0xFFC4BDB0),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aradığınız kitap bulunamadı.',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'serif',
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.61,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookCard(
                        book: book,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/book-detail',
                            arguments: book.id,
                          ).then((_) {
                            // Refresh FAB badge state if cart modified on details
                            setState(() {});
                          });
                        },
                        onAddToCart: () => _addToCart(book),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: cart.itemCount > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/cart').then((_) {
                  setState(() {});
                });
              },
              shape: const Border(
                bottom: BorderSide(color: Color(0xFF1C1A17), width: 1.5),
                right: BorderSide(color: Color(0xFF1C1A17), width: 1.5),
                top: BorderSide(color: Color(0xFF1C1A17), width: 0.5),
                left: BorderSide(color: Color(0xFF1C1A17), width: 0.5),
              ),
              label: Text(
                'SEPETİ GÖR (${cart.itemCount})',
                style: const TextStyle(
                  fontFamily: 'sans-serif',
                  color: Color(0xFFFAF7F0),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  fontSize: 12,
                ),
              ),
              backgroundColor: const Color(0xFF1C1A17),
              elevation: 0,
            )
          : null,
    );
  }
}
