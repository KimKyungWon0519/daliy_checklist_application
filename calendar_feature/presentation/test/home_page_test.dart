import 'package:calendar_domain/domain.dart';
import 'package:calendar_presentation/pages/calendar_page/local_widgets/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:calendar_presentation/presentation.dart';

class MockHomeViewModel extends Mock implements CalendarViewModel {
  @override
  final StateProvider<DateTime> selectedDateProvider =
      StateProvider((ref) => DateTime.now());

  @override
  final StateProvider<List<Task>> selectedDateTasksProvider =
      StateProvider((ref) => []);

  @override
  final StateProvider<List<Task>> allTasksProvider = StateProvider((ref) => []);

  @override
  Future<List<Task>> getAllTasks() {
    return Future.value([]);
  }

  @override
  Future<List<Task>> getTaskOnSelectedDate(final DateTime date) {
    return Future.value([]);
  }
}

void main() {
  viewModelProvider
      .registerFactory<CalendarViewModel>(() => MockHomeViewModel());
  testWidgets('Test ui of home screen', (widgetTester) async {
    await widgetTester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CalendarPage(),
        ),
      ),
    );

    expect(find.byType(CustomCalendar), findsOneWidget);
    expect(find.byType(LayoutBuilder), findsOneWidget);
  });
}
