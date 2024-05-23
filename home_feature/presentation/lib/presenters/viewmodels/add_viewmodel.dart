import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddViewModel {
  late final AddTask _addTaskUseCase;

  late final StateProvider<DateType> dateTypeProvider;
  late final StateProvider<Task> taskProvider;

  AddViewModel({
    required AddTask addTask,
  }) : _addTaskUseCase = addTask {
    dateTypeProvider = StateProvider<DateType>((ref) => DateType.daily);
    taskProvider = StateProvider<Task>((ref) => Task.empty());
  }

  Future<int> addTask(final Task task) {
    return _addTaskUseCase.addTask(task);
  }
}
