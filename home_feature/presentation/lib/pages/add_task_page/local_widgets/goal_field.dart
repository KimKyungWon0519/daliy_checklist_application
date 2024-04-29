import 'package:flutter/material.dart';

class GoalField extends StatelessWidget {
  const GoalField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
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
