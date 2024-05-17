import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/add_task_page/add_task_page.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_field.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_range_type_chips.dart';
import 'package:presentation/pages/add_task_page/local_widgets/goal_field.dart';
import 'package:presentation/presenters/viewmodels/add_viewmodel.dart';

void main() {
  viewModelProvider.registerFactory(() => AddViewModel());
  testWidgets('test goal input widget', (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AddTaskPage(
            initialDate: DateTime.now(),
          ),
        ),
      ),
    );

    expect(find.byType(GoalField), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(GoalField),
        matching: find.byType(TextField),
      ),
      findsOneWidget,
    );
    expect(find.byType(DateRangePicker), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(DateRangePicker),
        matching: find.byType(RawChip),
      ),
      findsWidgets,
    );
    expect(find.byType(DateField), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(DateField),
        matching: find.byType(TextField),
      ),
      findsOneWidget,
    );
  });
}
