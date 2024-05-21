import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/constants/ui_constants.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

import 'local_widgets/custom_calendar.dart';
import 'local_widgets/task_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  final Future<void> Function(DateTime)? pageNavigator;

  const HomePage({
    super.key,
    this.pageNavigator,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = viewModelProvider<HomeViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _viewModel.getAllTask(DateTime.now()).then((value) {
        ref.read(_viewModel.tasksProvider.notifier).update((state) => value);
      });
    });
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
                pageNavigator: widget.pageNavigator,
                selectedDateProvider: _viewModel.selectedDateProvider,
                tasksProvider: _viewModel.tasksProvider,
                onPressedAddButton: () => _onPressedAddButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedAddButton() {
    final DateTime selectedDate = ref.read(_viewModel.selectedDateProvider);

    print(selectedDate);

    if (widget.pageNavigator != null) {
      widget.pageNavigator!(selectedDate).then((value) async {
        List<Task> tasks = await _viewModel.getAllTask(selectedDate);

        ref.read(_viewModel.tasksProvider.notifier).update((state) => tasks);
      });
    }
  }
}
