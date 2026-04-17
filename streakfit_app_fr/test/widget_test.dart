import 'package:flutter_test/flutter_test.dart';
import 'package:streakfit/main.dart';
import 'package:streakfit/providers/auth_provider.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(StreakFitApp(auth: AuthProvider()));

    expect(find.text('Welcome to StreakFit'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });
}
