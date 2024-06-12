import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_feature/home_feature.dart';
import 'package:intl/intl.dart';
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
                    pageNavigator: (DateTime selectedDate) async {
                      await context.pushNamed(
                        'add',
                        pathParameters: {
                          'start_date':
                              DateFormat('yyyy/MM/dd').format(selectedDate),
                        },
                      );
                    },
                  ),
              routes: [
                GoRoute(
                  path: 'add/:start_date',
                  name: 'add',
                  builder: (context, state) {
                    final DateTime initialDate = DateFormat('yyyy/MM/dd')
                        .parse(state.pathParameters['start_date']!);

                    return EditTaskPage(
                      initialDate: initialDate,
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
