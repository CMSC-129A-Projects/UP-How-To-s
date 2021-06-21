// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uphowtos1/main.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(
    home: Scaffold(
      body: Text('H'),
    ),
  ));

  expect(find.text('H'), findsOneWidget);

});
}

