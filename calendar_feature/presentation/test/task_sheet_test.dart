import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/calendar_page/local_widgets/task_panel_body.dart';
import 'package:presentation/pages/calendar_page/local_widgets/task_panel_header.dart';
import 'package:presentation/pages/calendar_page/local_widgets/task_sheet.dart';
import 'package:presentation/presenters/viewmodels/calendar_viewmodel.dart';

class MockHomeViewModel extends Mock implements CalendarViewModel {
  @override
  final StateProvider<DateTime> selectedDateProvider =
      StateProvider((ref) => DateTime.now());

  @override
  final StateProvider<List<Task>> selectedDateTasksProvider =
      StateProvider((ref) => [Task.empty()]);
}

void main() {
  viewModelProvider
      .registerFactory<CalendarViewModel>(() => MockHomeViewModel());

  testWidgets(
    'check task sheet panel ui',
    (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TaskSheet(
              selectedDateProvider:
                  viewModelProvider<CalendarViewModel>().selectedDateProvider,
              tasksProvider: viewModelProvider<CalendarViewModel>()
                  .selectedDateTasksProvider,
            ),
          ),
        ),
      ));

      expect(find.byType(TaskSheet), findsOneWidget);
      expect(find.byType(SliverPersistentHeader), findsOneWidget);
      expect(find.byType(TaskPanelBody), findsOneWidget);

      final Finder sliverPersistentHeaderFinder =
          find.byType(SliverPersistentHeader);

      SliverPersistentHeader header =
          widgetTester.widget(sliverPersistentHeaderFinder);

      expect(header.delegate, isInstanceOf<Header>());

      expect(
        find.descendant(
          of: sliverPersistentHeaderFinder,
          matching: find.byType(Text),
        ),
        findsOneWidget,
      );

      expect(
        find.descendant(
          of: sliverPersistentHeaderFinder,
          matching: find.byType(Container),
        ),
        findsOneWidget,
      );

      expect(
        find.descendant(
          of: sliverPersistentHeaderFinder,
          matching: find.byType(IconButton),
        ),
        findsOneWidget,
      );
    },
  );
}
