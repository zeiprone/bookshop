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
  List<Book> books = [];
  List<String> categories = [];
  String selectedCategory = 'Tümü';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    books = BookData.getAllBooks();
    categories = BookData.getCategories();
    setState(() {});
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      books = BookData.getBooksByCategory(category);
    });
  }

  void _addToCart(Book book) {
    cart.addItem(book);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${book.title} sepete eklendi'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          AppHeader(title: '📚 İkinci El Kitap'),

          // Category Filter
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) => _filterByCategory(category),
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
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
                        Icon(
                          Icons.book_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Kitap bulunamadı',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
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
                          );
                        },
                        onAddToCart: () => _addToCart(book),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        label: Text('${cart.itemCount}'),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
