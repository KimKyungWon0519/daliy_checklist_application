import 'package:calendar_domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:calendar_presentation/constants/app_constants.dart';
import 'package:calendar_presentation/pages/calendar_page/local_widgets/custom_calendar.dart';
import 'package:calendar_presentation/pages/calendar_page/painters/calendar_painter.dart';
import 'package:calendar_presentation/presenters/viewmodels/calendar_viewmodel.dart';

class MockHomeViewModel extends Mock implements CalendarViewModel {
  @override
  final StateProvider<DateTime> selectedDateProvider =
      StateProvider((ref) => DateTime.now());

  @override
  final StateProvider<List<Task>> selectedDateTasksProvider =
      StateProvider((ref) => []);

  @override
  final StateProvider<List<Task>> allTasksProvider = StateProvider((ref) => []);
}

void main() {
  viewModelProvider
      .registerFactory<CalendarViewModel>(() => MockHomeViewModel());

  testWidgets('check calendar widget', (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CustomCalendar(
              selectedDateProvider:
                  viewModelProvider<CalendarViewModel>().selectedDateProvider,
              onPressedDay: (selectedDateTime) {},
              allTasksProvider:
                  viewModelProvider<CalendarViewModel>().allTasksProvider,
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
