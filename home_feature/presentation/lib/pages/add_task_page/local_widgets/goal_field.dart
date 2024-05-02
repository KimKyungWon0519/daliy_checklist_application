import 'package:flutter/material.dart';

class GoalField extends StatelessWidget {
  final void Function(String value) onChanged;

  const GoalField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: '목표',
        icon: Icon(Icons.short_text_rounded),
        contentPadding: EdgeInsets.all(8),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
