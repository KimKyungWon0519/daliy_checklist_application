import 'package:flutter/material.dart';

import 'task_panel_body.dart';
import 'task_panel_header.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  DraggableScrollableController _controller = DraggableScrollableController();

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
            color: Colors.teal[100],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: _TaskPanel(
            controller: _controller,
            scrollController: scrollController,
          ),
        );
      },
    );
  }
}

class _TaskPanel extends StatelessWidget {
  final DraggableScrollableController? controller;
  final ScrollController? scrollController;

  const _TaskPanel({
    super.key,
    this.controller,
    this.scrollController,
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
          ),
          pinned: true,
        ),
        const TaskPanelBody(),
      ],
    );
  }
}
