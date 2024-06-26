import 'package:calendar_domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_presentation/constants/ui_constants.dart';

import 'task_panel_body.dart';
import 'task_panel_header.dart';

class TaskSheet extends StatefulWidget {
  final StateProvider<DateTime> selectedDateProvider;
  final StateProvider<List<Task>> tasksProvider;
  final VoidCallback? onPressedAddButton;
  final void Function(Task task, bool value)? onChangedCompleted;
  final void Function(Task task)? onPressedTaskTile;

  const TaskSheet({
    super.key,
    required this.selectedDateProvider,
    required this.tasksProvider,
    this.onPressedAddButton,
    this.onChangedCompleted,
    this.onPressedTaskTile,
  });

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  late final DraggableScrollableController _controller;

  @override
  void initState() {
    super.initState();

    _controller = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: taskListPanelMinSize,
      minChildSize: taskListPanelMinSize,
      maxChildSize: taskListPanelMaxSize,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: TaskPanel(
            controller: _controller,
            scrollController: scrollController,
            selectedDateProvider: widget.selectedDateProvider,
            tasksProvider: widget.tasksProvider,
            onPressedAddButton: widget.onPressedAddButton,
            onChangedCompleted: widget.onChangedCompleted,
            onPressedTaskTile: widget.onPressedTaskTile,
          ),
        );
      },
    );
  }
}

class TaskPanel extends StatelessWidget {
  final DraggableScrollableController? controller;
  final ScrollController? scrollController;
  final StateProvider<DateTime> selectedDateProvider;
  final StateProvider<List<Task>> tasksProvider;
  final VoidCallback? onPressedAddButton;
  final void Function(Task task, bool value)? onChangedCompleted;
  final void Function(Task task)? onPressedTaskTile;

  const TaskPanel({
    super.key,
    this.controller,
    this.scrollController,
    required this.selectedDateProvider,
    required this.tasksProvider,
    this.onPressedAddButton,
    this.onChangedCompleted,
    this.onPressedTaskTile,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPersistentHeader(
          delegate: Header(
            draggableSheetController: controller,
            scrollController: scrollController,
            selectedDateProvider: selectedDateProvider,
            onPressedAddButton: onPressedAddButton,
          ),
          pinned: true,
        ),
        TaskPanelBody(
          tasksProvider: tasksProvider,
          onChangedCompleted: onChangedCompleted,
          onPressedTaskTile: onPressedTaskTile,
        ),
      ],
    );
  }
}
