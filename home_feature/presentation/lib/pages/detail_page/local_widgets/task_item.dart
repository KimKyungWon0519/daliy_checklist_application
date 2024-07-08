import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final Size textSize = getTextSize();

    return Container(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Color(task.colorCode).withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      height: textSize.height * 3,
      child: Row(
        children: [
          Container(
            width: textSize.height / 2,
            color: Color(task.colorCode),
          ),
          const SizedBox(width: 5),
          Text(task.goal),
          const Spacer(),
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Size getTextSize() {
    TextPainter textPainter =
        TextPainter(text: TextSpan(text: task.goal), maxLines: 1)
          ..textDirection = TextDirection.ltr
          ..layout();

    return Size(textPainter.width, textPainter.height);
  }
}
