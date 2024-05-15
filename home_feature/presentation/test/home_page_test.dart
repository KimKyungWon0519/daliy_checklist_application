import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:home_feature/constants/app_constants.dart';
import 'package:home_feature/pages/home_page/local_widgets/custom_calendar.dart';
import 'package:home_feature/pages/home_page/local_widgets/task_sheet.dart';
import 'package:home_feature/presentation.dart';
import 'package:home_feature/presenters/viewmodels/home_viewmodel.dart';

void main() {
  viewModelProvider = GetIt.I;
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
