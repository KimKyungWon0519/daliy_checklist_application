import 'dart:io';

import 'package:calendar_feature/calendar_feature.dart' as CalendarFeature;
import 'package:home_feature/home_feature.dart' as HomeFeature;
import 'package:path_provider/path_provider.dart';

Future<void> init() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  await CalendarFeature.initialize(directory.path);
  await HomeFeature.initialize(directory.path);
}
