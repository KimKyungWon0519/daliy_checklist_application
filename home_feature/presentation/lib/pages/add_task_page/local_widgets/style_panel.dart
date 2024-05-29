import 'package:flutter/material.dart';

import 'color_tile.dart';
import 'default_panel.dart';

class StylePanel extends StatelessWidget {
  const StylePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultPanel(
      children: [
        ColorTile(),
      ],
    );
  }
}
