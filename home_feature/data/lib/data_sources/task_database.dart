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

  Future<List<Task>> getAllTask() {
    return _isar.txn(() => _isar.tasks.where().findAll());
  }
}