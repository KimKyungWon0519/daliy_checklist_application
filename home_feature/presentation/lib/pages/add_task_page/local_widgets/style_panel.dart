import 'package:flutter/material.dart';

import 'default_panel.dart';

class StylePanel extends StatelessWidget {
  const StylePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPanel(
      children: [
        ListTile(
          title: const Text('색상'),
          leading: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
