import 'package:go_router/go_router.dart';
import 'package:presentation/pages/home_page/home_page.dart';

final GoRoute home = GoRoute(
  path: '/home',
  builder: (context, state) => const HomePage(),
);
