import 'package:flutter/material.dart';

import 'local_widgets/custom_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomCalendar(
            initialDateTime: DateTime(2024, 1),
          ),
        ),
      ),
    );
  }
}
