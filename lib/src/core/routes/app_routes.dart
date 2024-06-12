import 'package:go_router/go_router.dart';
import 'package:home_feature/home_feature.dart';
import 'package:intl/intl.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute home = GoRoute(
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
    routes: [add],
  );

  static final GoRoute add = GoRoute(
    path: 'add',
    name: 'add',
    builder: (context, state) {
      Map<String, dynamic> extra = state.extra! as Map<String, dynamic>;

      return EditTaskPage(
        initialDate: extra['start_date'],
        task: extra['task'],
        pageNavigator: () => context.pop(),
      );
    },
  );

  static final List<GoRoute> routes = [
    home,
  ];
}
