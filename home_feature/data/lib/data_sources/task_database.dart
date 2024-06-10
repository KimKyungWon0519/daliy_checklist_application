import 'package:data/entites/task.dart';
import 'package:isar/isar.dart';

class TaskDatabase {
  late final Isar _isar;

  TaskDatabase(String directory) {
    _isar = Isar.openSync(
      [TaskSchema],
      directory: directory,
    );
  }

  Future<int> addTask(Task task) {
    return _isar.writeTxn(() => _isar.tasks.put(task));
  }

  Future<int> updateTask(Task task) {
    return _isar.writeTxn(() => _isar.tasks.put(task));
  }

  Future<List<Task>> getTaskOnSelectedDate(DateTime selectedDate) {
    return _isar.txn(() => _isar.tasks
        .filter()
        .group((q) => q.startDateEqualTo(selectedDate).and().endDateIsNull())
        .or()
        .group((q) => q
            .startDateLessThan(selectedDate, include: true)
            .and()
            .endDateGreaterThan(selectedDate, include: true))
        .findAll());
  }

  Future<List<Task>> getAllTasks() {
    return _isar.txn(() => _isar.tasks.where().findAll());
  }
}
