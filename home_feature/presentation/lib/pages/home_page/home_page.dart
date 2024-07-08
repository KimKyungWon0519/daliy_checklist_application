import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/presentation.dart';

import './local_widgets/task_info_widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  final void Function(TasksType type, List<Task> tasks)? pageNavigator;

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _viewModel.addTaskUpdateListener((event) async {
      _viewModel.getAllTasks().then((value) {
        ref.read(_viewModel.tasksProvider.notifier).update((state) => value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = ref.watch(_viewModel.tasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('체크리스트'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TodayInfo(
              tasks: _viewModel.getTodayTasks(tasks),
              pageNavigator: widget.pageNavigator,
            ),
            PostponeInfo(
              tasks: _viewModel.getPostponeTasks(tasks),
              pageNavigator: widget.pageNavigator,
            ),
            FutureInfo(
              tasks: _viewModel.getFutureTasks(tasks),
              pageNavigator: widget.pageNavigator,
            ),
            AllInfo(
              tasks: tasks,
              pageNavigator: widget.pageNavigator,
            ),
            CompletedInfo(
              tasks: _viewModel.getCompletedTasks(tasks),
              pageNavigator: widget.pageNavigator,
            ),
          ],
        ),
      ),
    );
  }
}
