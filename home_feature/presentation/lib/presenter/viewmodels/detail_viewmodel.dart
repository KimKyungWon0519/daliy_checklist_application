import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel {
  late final StateProvider<List<Task>> tasksProvider;

  DetailViewModel() : tasksProvider = StateProvider((ref) => []);
}
