import 'package:flutter/material.dart';
import 'screens/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İkinci El Kitap Al-Sat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/book-detail': (context) {
          final bookId = ModalRoute.of(context)?.settings.arguments as int?;
          return BookDetailScreen(bookId: bookId ?? 0);
        },
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}

