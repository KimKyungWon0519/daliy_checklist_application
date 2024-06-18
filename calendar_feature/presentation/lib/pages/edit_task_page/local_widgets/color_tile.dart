import 'package:calendar_domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'color_picker_dialog.dart';

class ColorTile extends ConsumerStatefulWidget {
  final StateProvider<Task> taskProvider;

  const ColorTile({
    super.key,
    required this.taskProvider,
  });

  @override
  ConsumerState<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends ConsumerState<ColorTile> {
  @override
  Widget build(BuildContext context) {
    int colorCode = ref.watch(widget.taskProvider).colorCode;

    return ListTile(
      title: const Text('색상'),
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: Color(colorCode),
        ),
      ),
      onTap: () {
        showDialog<Color>(
          context: context,
          builder: (context) => ColorPickerDialog(
            color: Color(colorCode),
          ),
        ).then((value) {
          if (value != null) {
            ref
                .read(widget.taskProvider.notifier)
                .update((state) => state.copyWith(colorCode: value.value));
          }
        });
      },
    );
  }
}
