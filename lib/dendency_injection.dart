import 'dart:io';

import 'package:home_feature/home_feature.dart' as HomeFeature;
import 'package:path_provider/path_provider.dart';

Future<void> init() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  HomeFeature.initialize(directory.path);
}
