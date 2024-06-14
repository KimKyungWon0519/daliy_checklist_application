import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './task_info_card.dart';

class TodayInfo extends StatelessWidget {
  const TodayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskInfoCard(
      title: '오늘 할 일',
      date: DateFormat('yyyy/MM/dd').format(DateTime.now()),
      count: 0,
    );
  }
}

class PostponeInfo extends StatelessWidget {
  const PostponeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '앞으로 할 일',
      count: 0,
    );
  }
}

class FutureInfo extends StatelessWidget {
  const FutureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '남은 할 일',
      count: 0,
    );
  }
}

class AllInfo extends StatelessWidget {
  const AllInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '모든 할 일',
      count: 0,
    );
  }
}

class CompletedInfo extends StatelessWidget {
  const CompletedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskInfoCard(
      title: '완료된 일',
      count: 0,
    );
  }
}
