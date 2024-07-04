import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_feature/home_feature.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize((await getApplicationDocumentsDirectory()).path);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage(
              pageNavigator: (title, tasks) {
                context.push('/$title', extra: tasks);
              },
            ),
            routes: [
              GoRoute(
                path: ':type',
                builder: (context, state) {
                  final String title = state.pathParameters['type']!;
                  final dynamic tasks = state.extra!;

                  return DetailPage(
                    title: title,
                    tasks: tasks,
                  );
                },
              ),
            ],
          ),
        ],
        initialLocation: '/',
      ),
    );
  }
}
