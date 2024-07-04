import 'package:flutter/material.dart';
import 'package:presentation/pages/detail_page/local_widgets/daily_tile.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
