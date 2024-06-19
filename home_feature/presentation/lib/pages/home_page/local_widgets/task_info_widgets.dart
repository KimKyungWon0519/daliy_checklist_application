import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './task_info_card.dart';

class TodayInfo extends StatelessWidget {
  final List<Task> tasks;

  const TodayInfo({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      title: '오늘 할 일',
      date: DateFormat('yyyy/MM/dd').format(DateTime.now()),
      tasks: tasks,
    );
  }
}

class PostponeInfo extends StatelessWidget {
  const PostponeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '앞으로 할 일',
      tasks: [],
    );
  }
}

class FutureInfo extends StatelessWidget {
  const FutureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '남은 할 일',
      tasks: [],
    );
  }
}

class AllInfo extends StatelessWidget {
  final List<Task> tasks;

  const AllInfo({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      title: '모든 할 일',
      tasks: tasks,
    );
  }
}

class CompletedInfo extends StatelessWidget {
  const CompletedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '완료된 일',
      tasks: [],
    );
  }
}
