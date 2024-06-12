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
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => HomePage(
                    pageNavigator: ({dateTime, task}) async {
                      Map<String, dynamic> queryParameters = {};

                      if (dateTime != null) {
                        queryParameters.addAll({'start_date': dateTime});
                      } else if (task != null) {
                        queryParameters.addAll({'task': task});
                      }

                      await context.pushNamed(
                        'add',
                        extra: queryParameters,
                      );
                    },
                  ),
              routes: [
                GoRoute(
                  path: 'add',
                  name: 'add',
                  builder: (context, state) {
                    Map<String, dynamic> extra =
                        state.extra! as Map<String, dynamic>;

                    return EditTaskPage(
                      initialDate: extra['start_date'],
                      task: extra['task'],
                      pageNavigator: () => context.pop(),
                    );
                  },
                ),
              ]),
        ],
        initialLocation: '/home',
      ),
    );
  }
}
