import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_app/main.dart';

void main() {
  testWidgets('LocalBites app opens', (tester) async {
    await tester.pumpWidget(const LocalBitesApp());
    expect(find.text('LocalBites'), findsOneWidget);
  });
}
