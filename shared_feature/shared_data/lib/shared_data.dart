import 'package:isar/isar.dart';

import 'entities/task.dart';

export 'entities/task.dart';

Isar createIsar(String directory) {
  return Isar.openSync(
    [TaskSchema],
    directory: directory,
  );
}
