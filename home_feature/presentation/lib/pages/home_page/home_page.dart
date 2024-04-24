import 'package:flutter/material.dart';

import 'local_widgets/custom_calendar.dart';
import 'local_widgets/task_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: CustomCalendar(),
            ),
            SizedBox.expand(
              child: TaskSheet(),
            ),
          ],
        ),
      ),
    );
  }
}
