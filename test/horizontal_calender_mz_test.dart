import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_calender_mz/horizontal_calender_mz.dart';


void main() {
testWidgets('horizontal_calendar minimal test', (WidgetTester tester) async {
  // Build the widget
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: HorizontalCalenderMZ(
          key: const Key('horizontal_calendar'),
          startyear: 2000,
          endyear: 2050,
          footer: true,
        ),
      ),
    ),
  );

  // Verify that HorizontalCalenderMZ is displayed
  expect(find.byKey(const Key('horizontal_calendar')), findsOneWidget);
});
}