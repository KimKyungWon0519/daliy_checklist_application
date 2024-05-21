import 'package:domain/domain.dart';
import 'package:domain/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_field.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_range_type_chips.dart';
import 'package:presentation/presenters/viewmodels/add_viewmodel.dart';

import 'local_widgets/add_button.dart';
import 'local_widgets/goal_field.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  final DateTime initialDate;
  final void Function()? pageNavigator;

  const AddTaskPage({
    super.key,
    required this.initialDate,
    this.pageNavigator,
  });

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final AddViewModel addViewModel = viewModelProvider<AddViewModel>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(addViewModel.taskProvider.notifier).update((state) =>
            state.copyWith(
                selectedDate: SelectedDate(startDate: widget.initialDate)));
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 목표'),
        actions: [
          AddButton(
            onPressed: () => _onPressedAddButton(addViewModel),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.secondaryContainer),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: GoalField(
                  onChanged: (value) {
                    ref
                        .read(addViewModel.taskProvider.notifier)
                        .update((state) => state.copyWith(goal: value));
                  },
                ),
              ),
              const Divider(),
              DateRangePicker(
                dateTypeProvider: addViewModel.dateTypeProvider,
                taskProvider: addViewModel.taskProvider,
              ),
              DateField(
                dateTypeProvider: addViewModel.dateTypeProvider,
                taskProvider: addViewModel.taskProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedAddButton(final AddViewModel addViewModel) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Task task = ref.read(addViewModel.taskProvider);

      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));

      await addViewModel.addTask(task).then((value) => Navigator.pop(context));

      widget.pageNavigator?.call();
    }
  }
}
