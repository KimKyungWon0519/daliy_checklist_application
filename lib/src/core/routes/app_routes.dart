import 'package:go_router/go_router.dart';
import 'package:home_feat_presentation/presentation.dart';

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
