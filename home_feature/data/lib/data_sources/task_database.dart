import 'package:isar/isar.dart';
import 'package:shared_feature/shared_feature.dart';

class TaskDatabase {
  late final Isar _isar;

  TaskDatabase(String directory) : _isar = createIsar(directory);
}
