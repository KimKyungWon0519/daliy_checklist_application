import 'package:calendar_domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_presentation/constants/app_constants.dart';
import 'package:calendar_presentation/pages/edit_task_page/local_widgets/input_panel.dart';
import 'package:calendar_presentation/pages/edit_task_page/local_widgets/style_panel.dart';
import 'package:calendar_presentation/presenters/viewmodels/edit_viewmodel.dart';

import 'local_widgets/add_button.dart';

class EditTaskPage extends ConsumerStatefulWidget {
  final DateTime? initialDate;
  final void Function()? pageNavigator;
  final Task? task;

  const EditTaskPage({
    super.key,
    this.initialDate,
    this.pageNavigator,
    this.task,
  }) : assert(initialDate == null || task == null);

  @override
  ConsumerState<EditTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<EditTaskPage> {
  late final GlobalKey<FormState> _formKey;
  late final EditViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _viewModel = viewModelProvider<EditViewModel>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.task != null) {
          ref
              .read(_viewModel.taskProvider.notifier)
              .update((state) => widget.task!);

          if (widget.task!.selectedDate.endDate != null) {
            ref
                .read(_viewModel.dateTypeProvider.notifier)
                .update((state) => DateType.period);
          }
        } else {
          ref.read(_viewModel.taskProvider.notifier).update((state) =>
              state.copyWith(
                  selectedDate: SelectedDate(startDate: widget.initialDate!)));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('목표'),
        actions: [
          FinishButton(
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
