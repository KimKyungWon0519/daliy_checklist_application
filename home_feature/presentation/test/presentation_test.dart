import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pages/home_page/local_widgets/task_info_card.dart';
import 'package:presentation/pages/home_page/local_widgets/task_info_widgets.dart';
import 'package:presentation/presentation.dart';

void main() {
  group('test home page', () {
    testWidgets('test for task card ( show date )', (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TaskInfoCard(title: 'test', date: 'test', count: 0),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);

      Row row = widgetTester.widget(find.byType(Row));

      expect(row.children.first, isInstanceOf<Column>());
      expect(row.children.last, isInstanceOf<Text>());

      Column column = row.children.first as Column;

      expect(column.children.length, 2);

      expect(column.children.first, isInstanceOf<Text>());
      expect(column.children.last, isInstanceOf<Text>());
    });

    testWidgets('test for task card ( unshow date )', (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TaskInfoCard(title: 'test', count: 0),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);

      Row row = widgetTester.widget(find.byType(Row));

      expect(row.children.first, isInstanceOf<Column>());
      expect(row.children.last, isInstanceOf<Text>());

      Column column = row.children.first as Column;

      expect(column.children.length, 1);

      expect(column.children.first, isInstanceOf<Text>());
    });

    testWidgets('home page', (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.byType(TodayInfo), findsOneWidget);
      expect(find.byType(PostponeInfo), findsOneWidget);
      expect(find.byType(FutureInfo), findsOneWidget);
    });
  });
}
