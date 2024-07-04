import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/pages/detail_page/local_widgets/daily_tile.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final List<Task> tasks;

  const DetailPage({
    super.key,
    required this.title,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return DailyTile(
              dateTime: DateTime.now().add(Duration(days: index)),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
