import 'package:flutter/material.dart';

class TaskPanelBody extends StatelessWidget {
  const TaskPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
