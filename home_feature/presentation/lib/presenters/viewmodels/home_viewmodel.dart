import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final StateProvider<DateTime> selectedDateProvider;

  HomeViewModel() {
    selectedDateProvider = StateProvider((ref) => DateTime.now());
  }
}
