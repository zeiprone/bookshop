// Basic widget tests for the second-hand book buy-sell app.

import 'package:flutter_test/flutter_test.dart';

import 'package:bookshop/main.dart';
import 'package:bookshop/models/index.dart';
import 'package:bookshop/widgets/index.dart';

void main() {
  testWidgets(
    'Home screen shows the catalog and navigates to a book detail',
    (WidgetTester tester) async {
      Cart().clear();
      await BookData.loadBooks();

      await tester.pumpWidget(const MyApp());
      await tester.pump();

      expect(find.text('İkinci El Kitap'), findsOneWidget);
      expect(find.text('Kürk Mantı Kolağası'), findsOneWidget);

      await tester.tap(find.byType(BookCard).first);
      await tester.pumpAndSettle();

      expect(find.text('Kitap Detayı'), findsOneWidget);
      expect(find.text('Yazar: Sabahattin Ali'), findsOneWidget);
    },
  );
}
