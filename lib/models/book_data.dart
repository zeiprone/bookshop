import 'book.dart';

/// Sample book data for the second-hand book application
class BookData {
  static List<Book> getAllBooks() {
    return [
      Book(
        id: 1,
        title: 'Kürk Mantı Kolağası',
        author: 'Sabahattin Ali',
        category: 'Türk Edebiyatı',
        price: 45.00,
        condition: 'Excellent',
        imageUrl: 'https://via.placeholder.com/200x300?text=Kürk+Mantı+Kolağası',
        description: 'Türk edebiyatının klasik eseri, derinlemesine insani ilişkileri anlatan bir roman.',
        pages: 152,
        isbn: '978-9754000512',
        sellerName: 'Ahmet K.',
        sellerPhone: '+90 532 123 4567',
      ),
      Book(
        id: 2,
        title: 'Bir Mühendisen Notları',
        author: 'Oğuz Atay',
        category: 'Türk Edebiyatı',
        price: 55.00,
        condition: 'Good',
        imageUrl: 'https://via.placeholder.com/200x300?text=Bir+Mühendisten+Notları',
        description: 'Modern insanın yalnızlığını ve çelişkilerini derinlemesine işleyen bir eser.',
        pages: 632,
        isbn: '978-9754003001',
        sellerName: 'Zeynep Y.',
        sellerPhone: '+90 533 987 6543',
      ),
      Book(
        id: 3,
        title: 'Dune',
        author: 'Frank Herbert',
        category: 'Science Fiction',
        price: 60.00,
        condition: 'Excellent',
        imageUrl: 'https://via.placeholder.com/200x300?text=Dune',
        description: 'Uzayda cereyan eden ve politika, diniyeti muhteviyetçi meşhur bilim kurgusunun başyapıtı.',
        pages: 688,
        isbn: '978-0-441-13959-7',
        sellerName: 'Mehmet S.',
        sellerPhone: '+90 534 456 7890',
      ),
      Book(
        id: 4,
        title: '1984',
        author: 'George Orwell',
        category: 'Distopya',
        price: 50.00,
        condition: 'Good',
        imageUrl: 'https://via.placeholder.com/200x300?text=1984',
        description: 'Totaliter bir toplumdaki insani özgürlüğün kaybedilişini anlatan uyarıcı bir roman.',
        pages: 328,
        isbn: '978-0-451-52493-5',
        sellerName: 'Fatma T.',
        sellerPhone: '+90 535 321 8765',
      ),
      Book(
        id: 5,
        title: 'Suç ve Ceza',
        author: 'Fyodor Dostoyevski',
        category: 'Klasik Edebiyat',
        price: 65.00,
        condition: 'Excellent',
        imageUrl: 'https://via.placeholder.com/200x300?text=Suç+ve+Ceza',
        description: 'Mantısal çelişkileri ve vicdan sorgulamalarını derinlemesine işleyen psikolojik roman.',
        pages: 645,
        isbn: '978-9789754609670',
        sellerName: 'Ali P.',
        sellerPhone: '+90 536 147 2580',
      ),
      Book(
        id: 6,
        title: 'Sefiller',
        author: 'Victor Hugo',
        category: 'Klasik Edebiyat',
        price: 70.00,
        condition: 'Fair',
        imageUrl: 'https://via.placeholder.com/200x300?text=Sefiller',
        description: 'Sosyal adaletin en zarif şekilde işlendiği bir edebi başyapıt.',
        pages: 1248,
        isbn: '978-9789754602901',
        sellerName: 'Leyla D.',
        sellerPhone: '+90 537 258 3691',
      ),
      Book(
        id: 7,
        title: 'Sapiens',
        author: 'Yuval Noah Harari',
        category: 'Tarih/Bilim',
        price: 75.00,
        condition: 'Excellent',
        imageUrl: 'https://via.placeholder.com/200x300?text=Sapiens',
        description: 'İnsanlığın evrimini ve tarihsel gelişimini anlaşılır bir şekilde anlatan çağdaş bir eser.',
        pages: 464,
        isbn: '978-9789750535891',
        sellerName: 'Serhat B.',
        sellerPhone: '+90 538 369 4702',
      ),
      Book(
        id: 8,
        title: 'Hayaller Büyüsü',
        author: 'Paulo Coelho',
        category: 'Kişisel Gelişim',
        price: 40.00,
        condition: 'Good',
        imageUrl: 'https://via.placeholder.com/200x300?text=Hayaller+Büyüsü',
        description: 'Insanın yaşamının anlamını ve kişisel gelişimini sorgulatan ilham verici bir kitap.',
        pages: 224,
        isbn: '978-9759990029',
        sellerName: 'Mira G.',
        sellerPhone: '+90 539 480 5813',
      ),
    ];
  }

  static List<String> getCategories() {
    final books = getAllBooks();
    final categories = <String>{};
    for (var book in books) {
      categories.add(book.category);
    }
    return ['Tümü', ...categories];
  }

  static List<Book> getBooksByCategory(String category) {
    if (category == 'Tümü') {
      return getAllBooks();
    }
    return getAllBooks().where((book) => book.category == category).toList();
  }

  static Book? getBookById(int id) {
    try {
      return getAllBooks().firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }
}
