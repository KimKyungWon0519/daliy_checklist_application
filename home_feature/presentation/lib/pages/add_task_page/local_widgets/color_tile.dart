import 'package:flutter/material.dart';
import 'package:presentation/pages/add_task_page/local_widgets/color_picker_dialog.dart';

class ColorTile extends StatefulWidget {
  const ColorTile({super.key});

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
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
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ColorPickerDialog(),
        );
      },
    );
  }
}
