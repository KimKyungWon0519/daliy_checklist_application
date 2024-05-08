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
}
