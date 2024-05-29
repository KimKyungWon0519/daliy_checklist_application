import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  const ColorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('색상'),
      leading: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.red,
        ),
      ),
    );
  }
}
