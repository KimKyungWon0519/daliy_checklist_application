import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pages/home_page/local_widgets/custom_calendar.dart';
import 'package:presentation/pages/home_page/local_widgets/task_sheet.dart';
import 'package:presentation/presentation.dart';

void main() {
  viewModelProvider.registerFactory(() => HomeViewModel());
  testWidgets('Test ui of home screen', (widgetTester) async {
    await widgetTester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    expect(find.byType(CustomCalendar), findsOneWidget);
    expect(find.byType(TaskSheet), findsOneWidget);
  });
}
