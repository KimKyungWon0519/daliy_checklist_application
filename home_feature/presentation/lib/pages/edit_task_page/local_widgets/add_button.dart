import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FinishButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('추가'),
    );
  }
}
