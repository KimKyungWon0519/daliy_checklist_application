import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

class TaskPanelBody extends ConsumerWidget {
  const TaskPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel homeViewModel = viewModelProvider<HomeViewModel>();

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
