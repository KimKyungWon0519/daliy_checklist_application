import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_feature/constants/ui_constants.dart';

import 'task_panel_body.dart';
import 'task_panel_header.dart';

class TaskSheet extends StatefulWidget {
  final Function(DateTime)? onClickAddButton;
  final StateProvider<DateTime> selectedDateProvider;

  const TaskSheet({
    super.key,
    this.onClickAddButton,
    required this.selectedDateProvider,
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
          child: _TaskPanel(
            controller: _controller,
            scrollController: scrollController,
            onClickAddButton: widget.onClickAddButton,
            selectedDateProvider: widget.selectedDateProvider,
          ),
        );
      },
    );
  }
}

class _TaskPanel extends StatelessWidget {
  final DraggableScrollableController? controller;
  final ScrollController? scrollController;
  final Function(DateTime)? onClickAddButton;
  final StateProvider<DateTime> selectedDateProvider;

  const _TaskPanel({
    super.key,
    this.controller,
    this.scrollController,
    this.onClickAddButton,
    required this.selectedDateProvider,
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
            onClickAddButton: onClickAddButton,
            selectedDateProvider: selectedDateProvider,
          ),
          pinned: true,
        ),
        const TaskPanelBody(),
      ],
    );
  }
}
