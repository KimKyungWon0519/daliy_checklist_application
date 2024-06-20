import 'package:isar/isar.dart';

import 'entities/task.dart';

export 'entities/task.dart';

Isar createIsar(String directory) {
  Isar? isar = Isar.getInstance();

  return isar ??
      Isar.openSync(
        [TaskSchema],
        directory: directory,
      );
}
