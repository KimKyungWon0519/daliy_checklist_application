import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final StateProvider<DateTime> selectedDateProvider;
  late final StateProvider<List<Task>> tasksProvider;

  HomeViewModel() {
    selectedDateProvider = StateProvider((ref) => DateTime.now());
    tasksProvider = StateProvider((ref) => []);
  }
}
