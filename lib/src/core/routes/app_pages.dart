import 'package:go_router/go_router.dart';

import 'app_routes.dart';

final class AppPages {
  const AppPages._();

  static final String _initialLocation = AppRoutes.home.path;

  static final GoRouter routeConfig = GoRouter(
    routes: AppRoutes.routes,
    initialLocation: _initialLocation,
  );
}
