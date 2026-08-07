import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gatestep/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('GateStep app launches and renders splash screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: GateStepApp()));

    expect(find.text('G A T E S T E P'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}