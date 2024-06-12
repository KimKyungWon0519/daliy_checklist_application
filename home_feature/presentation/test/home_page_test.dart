import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/pages/home_page/local_widgets/custom_calendar.dart';
import 'package:presentation/pages/home_page/local_widgets/row_panel.dart';
import 'package:presentation/pages/home_page/local_widgets/stack_panel.dart';
import 'package:presentation/pages/home_page/local_widgets/task_sheet.dart';
import 'package:presentation/presentation.dart';

class MockHomeViewModel extends Mock implements HomeViewModel {
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
  viewModelProvider.registerFactory<HomeViewModel>(() => MockHomeViewModel());
  testWidgets('Test ui of home screen', (widgetTester) async {
    await widgetTester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    expect(find.byType(CustomCalendar), findsOneWidget);
    expect(find.byType(LayoutBuilder), findsOneWidget);
  });
}
