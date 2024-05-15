import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:home_feature/constants/app_constants.dart';
import 'package:home_feature/pages/home_page/local_widgets/task_panel_body.dart';
import 'package:home_feature/pages/home_page/local_widgets/task_panel_header.dart';
import 'package:home_feature/pages/home_page/local_widgets/task_sheet.dart';
import 'package:home_feature/presenters/viewmodels/home_viewmodel.dart';

void main() {
  viewModelProvider = GetIt.I;
  viewModelProvider.registerFactory(() => HomeViewModel());

  testWidgets(
    'check task sheet panel ui',
    (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TaskSheet(
              onClickAddButton: null,
              selectedDateProvider:
                  viewModelProvider<HomeViewModel>().selectedDateProvider,
            ),
          ),
        ),
      ));

      expect(find.byType(TaskSheet), findsOneWidget);
      expect(find.byType(SliverPersistentHeader), findsOneWidget);

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

      expect(find.byType(TaskPanelBody), findsOneWidget);
    },
  );
}
