import 'package:isar/isar.dart';
import 'package:shared_data/data.dart';

class TaskDatabase {
  late final Isar _isar;

  TaskDatabase(String directory) {
    _isar = createIsar(directory);
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
        .sortByIsCompleted()
        .findAll());
  }

  Future<List<Task>> getAllTasks() {
    return _isar.txn(() => _isar.tasks.where().findAll());
  }
}
