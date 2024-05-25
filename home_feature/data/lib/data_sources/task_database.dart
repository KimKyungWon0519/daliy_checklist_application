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

  Future<List<Task>> getTaskOnMonth(int year, int month) {
    final DateTime start = DateTime(year, month, 1);
    final DateTime end =
        DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

    return _isar
        .txn(() => _isar.tasks.filter().startDateBetween(start, end).findAll());
  }
}
