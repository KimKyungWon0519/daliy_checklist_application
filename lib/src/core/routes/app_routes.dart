import 'package:daily_checklist_application/src/feature/presentation/initial_page/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calendar_feature/calendar_feature.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute calendar = GoRoute(
    path: '/calendar',
    name: 'calendar',
    builder: (context, state) => CalendarPage(
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

  static final GoRoute home = GoRoute(
    path: '/home',
    name: 'home',
    builder: (context, state) {
      return Container();
    },
  );

  static final GoRoute menu = GoRoute(
    path: '/menu',
    name: 'menu',
    builder: (context, state) {
      return Container();
    },
  );

  static final StatefulShellRoute initial = StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(
        routes: [home],
      ),
      StatefulShellBranch(
        routes: [calendar],
      ),
      StatefulShellBranch(
        routes: [menu],
      ),
    ],
    builder: (context, state, navigationShell) =>
        InitialPage(navigationShell: navigationShell),
  );

  static final List<RouteBase> routes = [
    initial,
  ];
}
