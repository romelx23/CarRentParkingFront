import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cart_rent_parking/main.dart';

void main() {
  testWidgets('App loads successfully smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: CartRentParkingApp(),
      ),
    );

    expect(find.byType(CartRentParkingApp), findsOneWidget);
  });
}
