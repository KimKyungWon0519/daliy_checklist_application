import 'package:flutter/material.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/constants/ui_constants.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

import 'local_widgets/custom_calendar.dart';
import 'local_widgets/task_sheet.dart';

class HomePage extends StatefulWidget {
  final Function(DateTime)? onClickAddButton;

  const HomePage({
    super.key,
    this.onClickAddButton,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = viewModelProvider<HomeViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: bodyPadding,
              child: CustomCalendar(
                selectedDateProvider: _viewModel.selectedDateProvider,
              ),
            ),
            SizedBox.expand(
              child: TaskSheet(
                onClickAddButton: widget.onClickAddButton,
                selectedDateProvider: _viewModel.selectedDateProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
