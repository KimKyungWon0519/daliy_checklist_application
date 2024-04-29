import 'package:flutter/material.dart';

import 'task_panel_body.dart';
import 'task_panel_header.dart';

class TaskSheet extends StatefulWidget {
  final VoidCallback? onClickAddButton;

  const TaskSheet({
    super.key,
    this.onClickAddButton,
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
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 1,
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
          ),
        );
      },
    );
  }
}

class _TaskPanel extends StatelessWidget {
  final DraggableScrollableController? controller;
  final ScrollController? scrollController;
  final VoidCallback? onClickAddButton;

  const _TaskPanel({
    super.key,
    this.controller,
    this.scrollController,
    this.onClickAddButton,
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
          ),
          pinned: true,
        ),
        const TaskPanelBody(),
      ],
    );
  }
}
