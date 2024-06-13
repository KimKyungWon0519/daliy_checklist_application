import 'package:flutter/material.dart';

import './local_widgets/task_info_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('체크리스트'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: const Column(
          children: [
            TodayInfo(),
            PostponeInfo(),
            FutureInfo(),
          ],
        ),
      ),
    );
  }
}
