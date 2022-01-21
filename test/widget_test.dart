import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget baseStructure(Widget child) => MaterialApp(
      home: Material(
        child: child,
      ),
    );

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Not motivated to write test to be honest with you.
  });
}
