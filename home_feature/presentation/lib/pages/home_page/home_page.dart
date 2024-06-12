import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/home_page/local_widgets/row_panel.dart';
import 'package:presentation/pages/home_page/local_widgets/stack_panel.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  final Future<void> Function({DateTime? dateTime, Task? task})? pageNavigator;

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
      final DateTime nowDate = DateTime.now();

      _viewModel.getTaskOnSelectedDate(nowDate).then((value) {
        ref
            .read(_viewModel.selectedDateTasksProvider.notifier)
            .update((state) => value);
      });

      _viewModel.getAllTasks().then((value) => ref
          .read(_viewModel.allTasksProvider.notifier)
          .update((state) => value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            if (width < height) {
              return StackPanel(
                selectedDateProvider: _viewModel.selectedDateProvider,
                allTasksProvider: _viewModel.allTasksProvider,
                selectedDateTasksProvider: _viewModel.selectedDateTasksProvider,
                onPressedDay: (dateTime) => _onPressedDay(dateTime),
                onPressedAddButton: _onPressedAddButton,
                onChangedCompleted: _onChangedCompleted,
                onPressedTaskTile: _onPressedTaskTile,
              );
            } else {
              return RowPanel(
                selectedDateProvider: _viewModel.selectedDateProvider,
                allTaskProvider: _viewModel.allTasksProvider,
                selectedDateTasksProvider: _viewModel.selectedDateTasksProvider,
                onPressedDay: (dateTime) => _onPressedDay(dateTime),
                onPressedAddButton: _onPressedAddButton,
                onChangedCompleted: _onChangedCompleted,
                onPressedTaskTile: _onPressedTaskTile,
              );
            }
          },
        ),
      ),
    );
  }

  void _onPressedAddButton() {
    final DateTime selectedDate = ref.read(_viewModel.selectedDateProvider);

    if (widget.pageNavigator != null) {
      widget.pageNavigator!(dateTime: selectedDate).then((value) async {
        await _viewModel.getTaskOnSelectedDate(selectedDate).then((value) => ref
            .read(_viewModel.selectedDateTasksProvider.notifier)
            .update((state) => value));

        await _viewModel.getAllTasks().then((value) => ref
            .read(_viewModel.allTasksProvider.notifier)
            .update((state) => value));
      });
    }
  }

  void _onPressedTaskTile(Task task) {
    if (widget.pageNavigator != null) {
      widget.pageNavigator!(task: task).then((value) {
        _updateTask();
      });
    }
  }

  Future<void> _onPressedDay(DateTime selectedDateTime) async {
    ref
        .read(_viewModel.selectedDateProvider.notifier)
        .update((state) => selectedDateTime);

    List<Task> tasks = await _viewModel.getTaskOnSelectedDate(selectedDateTime);

    ref
        .read(_viewModel.selectedDateTasksProvider.notifier)
        .update((state) => tasks);
  }

  void _onChangedCompleted(Task task, bool value) {
    _viewModel.changedCompleted(task, value).then((value) async {
      _updateTask();
    });
  }

  void _updateTask() async {
    DateTime dateTime = ref.read(_viewModel.selectedDateProvider);

    List<Task> selectedDateTasks =
        await _viewModel.getTaskOnSelectedDate(dateTime);
    List<Task> allTasks = await _viewModel.getAllTasks();

    ref.read(_viewModel.allTasksProvider.notifier).update((state) => allTasks);
    ref
        .read(_viewModel.selectedDateTasksProvider.notifier)
        .update((state) => selectedDateTasks);
  }
}
