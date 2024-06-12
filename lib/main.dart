import 'package:daily_checklist_application/dendency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

void main() {
  init();

  runApp(const ProviderScope(child: MainApp()));
}
