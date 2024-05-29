import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/home_page/local_widgets/custom_calendar.dart';
import 'package:presentation/pages/home_page/painters/calendar_painter.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

class MockHomeViewModel extends Mock implements HomeViewModel {
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
  viewModelProvider.registerFactory<HomeViewModel>(() => MockHomeViewModel());

  testWidgets('check calendar widget', (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CustomCalendar(
              selectedDateProvider:
                  viewModelProvider<HomeViewModel>().selectedDateProvider,
              onPressedDay: (selectedDateTime) {},
              allTasksProvider:
                  viewModelProvider<HomeViewModel>().allTasksProvider,
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
