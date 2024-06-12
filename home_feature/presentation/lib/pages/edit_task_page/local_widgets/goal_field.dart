import 'package:flutter/material.dart';

class GoalField extends StatelessWidget {
  final String? initialValue;
  final void Function(String value) onChanged;

  const GoalField({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(text: initialValue),
      decoration: const InputDecoration(
        labelText: '목표',
        icon: Icon(Icons.short_text_rounded),
        contentPadding: EdgeInsets.all(8),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: _validator,
      onSaved: (newValue) => onChanged(newValue!),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  String? _validator(final String? value) {
    if (value == null || value.isEmpty) return '목표를 입력해주세요.';

    return null;
  }
}
