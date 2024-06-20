import 'package:calendar_domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'color_tile.dart';
import 'default_panel.dart';

class StylePanel extends StatelessWidget {
  final StateProvider<Task> taskProvider;

  const StylePanel({
    super.key,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPanel(
      children: [
        ColorTile(
          taskProvider: taskProvider,
        ),
      ],
    );
  }
}
