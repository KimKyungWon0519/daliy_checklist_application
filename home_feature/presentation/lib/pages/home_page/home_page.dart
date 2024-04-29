import 'package:flutter/material.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

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
    final HomeViewModel viewModel = viewModelProvider<HomeViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomCalendar(
                selectedDateProvider: viewModel.selectedDateProvider,
              ),
            ),
            SizedBox.expand(
              child: TaskSheet(
                onClickAddButton: onClickAddButton,
                selectedDateProvider: viewModel.selectedDateProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
