import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskPanelBody extends ConsumerWidget {
  const TaskPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CheckboxListTile(
            title: Text('$index'),
            value: false,
            onChanged: (value) {},
          );
        },
        childCount: 100,
      ),
    );
  }
}
