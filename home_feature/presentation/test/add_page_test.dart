import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:home_feature/constants/app_constants.dart';
import 'package:home_feature/pages/add_task_page/local_widgets/date_field.dart';
import 'package:home_feature/pages/add_task_page/local_widgets/date_range_type_chips.dart';
import 'package:home_feature/pages/add_task_page/local_widgets/goal_field.dart';
import 'package:home_feature/presentation.dart';
import 'package:home_feature/presenters/viewmodels/add_viewmodel.dart';

void main() {
  viewModelProvider = GetIt.I;
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
