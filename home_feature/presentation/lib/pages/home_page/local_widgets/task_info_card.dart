import 'package:flutter/material.dart';

class TaskInfoCard extends StatelessWidget {
  final String title;
  final String? date;
  final int count;

  const TaskInfoCard({
    super.key,
    required this.title,
    required this.count,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (date != null) Text(date!),
              ],
            ),
            const Spacer(),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
