import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './task_info_card.dart';

class TodayInfo extends StatelessWidget {
  final List<Task> tasks;
  final void Function(TasksType type, List<Task> tasks)? pageNavigator;

  const TodayInfo({
    super.key,
    required this.tasks,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      type: TasksType.today,
      date: DateFormat('yyyy/MM/dd').format(DateTime.now()),
      tasks: tasks,
      pageNavigator: pageNavigator,
    );
  }
}

class PostponeInfo extends StatelessWidget {
  final List<Task> tasks;
  final void Function(TasksType type, List<Task> tasks)? pageNavigator;

  const PostponeInfo({
    super.key,
    required this.tasks,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      type: TasksType.postpone,
      tasks: tasks,
      pageNavigator: pageNavigator,
    );
  }
}

class FutureInfo extends StatelessWidget {
  final List<Task> tasks;
  final void Function(TasksType type, List<Task> tasks)? pageNavigator;

  const FutureInfo({
    super.key,
    required this.tasks,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      type: TasksType.future,
      tasks: tasks,
      pageNavigator: pageNavigator,
    );
  }
}

class AllInfo extends StatelessWidget {
  final List<Task> tasks;
  final void Function(TasksType type, List<Task> tasks)? pageNavigator;

  const AllInfo({
    super.key,
    required this.tasks,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      type: TasksType.all,
      tasks: tasks,
      pageNavigator: pageNavigator,
    );
  }
}

class CompletedInfo extends StatelessWidget {
  final List<Task> tasks;
  final void Function(TasksType type, List<Task> tasks)? pageNavigator;

  const CompletedInfo({
    super.key,
    required this.tasks,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      type: TasksType.completed,
      tasks: tasks,
      pageNavigator: pageNavigator,
    );
  }
}
