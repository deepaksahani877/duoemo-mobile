import 'package:flutter_test/flutter_test.dart';
import 'package:duoemo/app/app.dart';
import 'package:duoemo/app/di/injection.dart';

void main() {
  testWidgets('Welcome screen renders correctly smoke test',
      (WidgetTester tester) async {
    await setupDependencies();
    await tester.pumpWidget(const DuoemoApp());

    expect(find.text('Create Your Duo'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });
}
