import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/pages/detail_page/local_widgets/daily_tile.dart';
import 'package:presentation/pages/detail_page/local_widgets/task_item.dart';
import 'package:presentation/presentation.dart';

class MockDetailViewModel extends Mock implements DetailViewModel {
  @override
  final StateProvider<List<Task>> tasksProvider =
      StateProvider((ref) => [Task.empty()]);
}

void main() {
  viewModelProvider.registerFactory<DetailViewModel>(
    () => MockDetailViewModel(),
  );

  group('test detail page', () {
    testWidgets(
      'test for TaskItem',
      (widgetTester) async {
        await widgetTester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: TaskItem(
                  task: Task(
                    goal: 'goal',
                    colorCode: 0x00FF00FF,
                    selectedDate: SelectedDate(
                      startDate: DateTime.now(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(
          find.byWidgetPredicate(
            (widget) {
              if (widget is Container) {
                return widget.color?.value == 0x00FF00FF;
              }

              return false;
            },
          ),
          findsOneWidget,
        );

        expect(find.byType(Text), findsOneWidget);

        final Text text = widgetTester.widget(find.byType(Text));

        expect(text.data, 'goal');
      },
    );

    testWidgets('test for DailyTile', (widgetTester) async {
      final DateTime dateTime = DateTime.now();
      final List<Task> tasks = [
        Task(
          goal: 'goal_1',
          selectedDate: SelectedDate(startDate: dateTime),
          colorCode: Random().nextInt(0xFFFFFFFF),
        ),
        Task(
          goal: 'goal_2',
          selectedDate: SelectedDate(startDate: dateTime),
          colorCode: Random().nextInt(0xFFFFFFFF),
        ),
      ];

      await widgetTester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DailyTile(
                dateTime: dateTime,
                tasks: tasks,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ExpansionTile), findsOneWidget);

      ExpansionTile expansionTile =
          widgetTester.widget(find.byType(ExpansionTile));

      assert(expansionTile.title is Text);

      expect((expansionTile.title as Text).data,
          DateFormat('yyyy-MM-dd').format(dateTime));
      expect(expansionTile.children.length, tasks.length);

      for (int i = 0; i < expansionTile.children.length; i++) {
        expect(expansionTile.children[i], isInstanceOf<TaskItem>());
      }
    });

    testWidgets(
      'test for detail page',
      (widgetTester) async {
        await widgetTester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
                home: DetailPage(
              tasks: [Task.empty()],
              type: TasksType.all,
            )),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
        expect(
            find.descendant(
                of: find.byType(ListView), matching: find.byType(DailyTile)),
            findsWidgets);
      },
    );
  });
}
