import 'package:isar/isar.dart';
import 'package:shared_data/shared_data.dart';

class TaskDatabase {
  late final Isar _isar;

  TaskDatabase(String directory) : _isar = createIsar(directory);

  Stream<void> getTasksChangedWatcher() {
    return _isar.tasks.watchLazy();
  }

  Future<List<Task>> getAllTasks() {
    return _isar.txn(() => _isar.tasks.where().findAll());
  }
}
