import 'package:daily_checklist_application/src/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute home = GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  );

  static final List<GoRoute> routes = [
    home,
  ];
}
