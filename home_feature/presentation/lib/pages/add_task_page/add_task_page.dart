import 'package:domain/domain.dart';
import 'package:domain/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_field.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_range_type_chips.dart';
import 'package:presentation/pages/add_task_page/local_widgets/input_panel.dart';
import 'package:presentation/pages/add_task_page/local_widgets/style_panel.dart';
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
  late final AddViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _viewModel = viewModelProvider<AddViewModel>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(_viewModel.taskProvider.notifier).update((state) =>
            state.copyWith(
                selectedDate: SelectedDate(startDate: widget.initialDate)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('새로운 목표'),
        actions: [
          AddButton(
            onPressed: () => _onPressedAddButton(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: InputPanel(
                  dateTypeProvider: _viewModel.dateTypeProvider,
                  taskProvider: _viewModel.taskProvider,
                ),
              ),
              const SizedBox(height: 5),
              StylePanel(
                taskProvider: _viewModel.taskProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedAddButton() async {
    FocusScope.of(context).unfocus();

    // keyboard unfocus delay
    await Future.delayed(const Duration(milliseconds: 100));

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Task task = ref.read(_viewModel.taskProvider);

      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));

      await _viewModel.addTask(task).then((value) => Navigator.pop(context));

      widget.pageNavigator?.call();
    }
  }
}
