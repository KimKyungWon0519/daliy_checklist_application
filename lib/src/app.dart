import 'package:daily_checklist_application/src/core/routes/app_pages.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppPages.routeConfig,
    );
  }
}
