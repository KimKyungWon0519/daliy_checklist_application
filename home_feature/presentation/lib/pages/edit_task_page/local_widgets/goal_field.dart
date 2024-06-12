import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoalField extends ConsumerWidget {
  final StateProvider<Task> taskProvider;
  String? _text;

  GoalField({
    super.key,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Task task = ref.watch(taskProvider);

    if (_text == null && task.goal.isNotEmpty) {
      _text = task.goal;
    }

    return TextFormField(
      controller: TextEditingController(text: _text),
      decoration: const InputDecoration(
        labelText: '목표',
        icon: Icon(Icons.short_text_rounded),
        contentPadding: EdgeInsets.all(8),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: _validator,
      onChanged: (value) => _text = value,
      onSaved: (newValue) {
        ref
            .read(taskProvider.notifier)
            .update((state) => state.copyWith(goal: newValue));
      },
      onTapOutside: (event) {
        ref
            .read(taskProvider.notifier)
            .update((state) => state.copyWith(goal: _text));

        FocusScope.of(context).unfocus();
      },
    );
  }

  String? _validator(final String? value) {
    if (value == null || value.isEmpty) return '목표를 입력해주세요.';

    return null;
  }
}
