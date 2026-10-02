import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_activity/main.dart';

void main() {
  testWidgets('Profile card shows required widgets', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Example Layout'), findsOneWidget);
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Name: Armand Sarsale'), findsOneWidget);
    expect(find.text('Age: 21'), findsOneWidget);
    expect(find.text('Location: Tubigon'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2));
  });
}
