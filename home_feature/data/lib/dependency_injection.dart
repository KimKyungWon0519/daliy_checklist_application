import 'package:isar/isar.dart';

Future<void> initialize() async {
  await Isar.initializeIsarCore(download: true);
}
