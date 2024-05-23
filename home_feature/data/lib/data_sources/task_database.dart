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

  Future<List<Task>> getAllTask(DateTime date) {
    return _isar.txn(() => _isar.tasks
        .filter()
        .group((q) => q.startDateEqualTo(date).and().endDateIsNull())
        .or()
        .group((q) => q
            .startDateLessThan(date, include: true)
            .and()
            .endDateGreaterThan(date, include: true))
        .findAll());
  }
}
