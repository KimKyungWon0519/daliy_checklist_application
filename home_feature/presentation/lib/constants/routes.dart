import 'package:go_router/go_router.dart';
import 'package:presentation/pages/add_task_page/add_task_page.dart';
import 'package:presentation/pages/home_page/home_page.dart';

final GoRoute home = GoRoute(
  path: '/home',
  name: 'home',
  routes: [
    add,
  ],
  builder: (context, state) => const HomePage(),
);

final GoRoute add = GoRoute(
  name: 'add',
  path: 'add',
  builder: (context, state) => const AddTaskPage(),
);
