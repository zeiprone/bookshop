import 'package:flutter/material.dart';
import 'models/index.dart';
import 'screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BookData.loadBooks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İkinci El Kitap Al-Sat',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8A3324),
          primary: const Color(0xFF8A3324),
          surface: const Color(0xFFFAF7F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F0),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'serif', color: Color(0xFF1C1A17), fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontFamily: 'serif', color: Color(0xFF1C1A17), fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'sans-serif', color: Color(0xFF2E2B2A)),
          bodyMedium: TextStyle(fontFamily: 'sans-serif', color: Color(0xFF2E2B2A)),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFFFAF7F0),
          elevation: 0,
          shape: Border(
            bottom: BorderSide(color: Color(0xFFE5DFD3), width: 1.5),
            right: BorderSide(color: Color(0xFFE5DFD3), width: 1.5),
            top: BorderSide(color: Color(0xFFE5DFD3), width: 0.5),
            left: BorderSide(color: Color(0xFFE5DFD3), width: 0.5),
          ),
        ),
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

