import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/pages/add_task_page/add_task_page.dart';
import 'package:presentation/pages/home_page/home_page.dart';
import 'package:presentation/presentation.dart';

void main() {
  initialize();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => HomePage(
                    onClickAddButton: () {
                      context.pushNamed('add');
                    },
                  ),
              routes: [
                GoRoute(
                  path: 'add',
                  name: 'add',
                  builder: (context, state) => const AddTaskPage(),
                ),
              ]),
        ],
        initialLocation: '/home',
      ),
    );
  }
}
