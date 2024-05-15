import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:home_feature/constants/app_constants.dart';
import 'package:home_feature/pages/home_page/local_widgets/custom_calendar.dart';
import 'package:home_feature/pages/home_page/painters/calendar_painter.dart';
import 'package:home_feature/presenters/viewmodels/home_viewmodel.dart';

void main() {
  viewModelProvider = GetIt.I;
  viewModelProvider.registerFactory(() => HomeViewModel());

  testWidgets('check calendar widget', (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CustomCalendar(
              selectedDateProvider:
                  viewModelProvider<HomeViewModel>().selectedDateProvider,
            ),
          ),
        ),
      ),
    );

    Column column = widgetTester.widget(find.byType(Column));

    expect(
      find.descendant(
        of: find.byWidget(column.children.first),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );

    CustomPaint customPaint = widgetTester.widget(find.descendant(
      of: find.byType(CustomCalendar),
      matching: find.byType(CustomPaint),
    ));

    expect(customPaint.painter, isInstanceOf<CalendarPainter>());
  });
}
