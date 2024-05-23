import 'package:go_router/go_router.dart';
import 'package:home_feature/home_feature.dart';
import 'package:intl/intl.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute home = GoRoute(
    path: '/home',
    name: 'home',
    builder: (context, state) => HomePage(
      pageNavigator: (DateTime selectedDate) async {
        await context.pushNamed(
          add.name!,
          pathParameters: {
            'start_date': DateFormat('yyyy/MM/dd').format(selectedDate),
          },
        );
      },
    ),
    routes: [add],
  );

  static final GoRoute add = GoRoute(
    path: 'add/:start_date',
    name: 'add',
    builder: (context, state) {
      final DateTime initialDate =
          DateFormat('yyyy/MM/dd').parse(state.pathParameters['start_date']!);

      return AddTaskPage(
        initialDate: initialDate,
        pageNavigator: () => context.pop(),
      );
    },
  );

  static final List<GoRoute> routes = [
    home,
  ];
}
