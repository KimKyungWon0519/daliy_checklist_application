import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:domain/model/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddViewModel {
  late final StateProvider<DateType> dateTypeProvider;
  late final StateProvider<Task> taskProvider;

  AddViewModel() {
    dateTypeProvider = StateProvider<DateType>((ref) => DateType.daily);
    taskProvider = StateProvider<Task>((ref) => Task.empty());
  }

  void addTask(Task task) {
    log(task.toString());
  }
}
