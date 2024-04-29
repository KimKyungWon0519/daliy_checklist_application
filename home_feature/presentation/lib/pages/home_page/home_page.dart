import 'package:flutter/material.dart';

import 'local_widgets/custom_calendar.dart';
import 'local_widgets/task_sheet.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onClickAddButton;

  const HomePage({
    super.key,
    this.onClickAddButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: CustomCalendar(),
            ),
            SizedBox.expand(
              child: TaskSheet(onClickAddButton: onClickAddButton),
            ),
          ],
        ),
      ),
    );
  }
}
