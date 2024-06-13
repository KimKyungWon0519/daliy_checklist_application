import 'dart:io';

import 'package:calendar_feature/calendar_feature.dart' as HomeFeature;
import 'package:path_provider/path_provider.dart';

Future<void> init() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  HomeFeature.initialize(directory.path);
}
