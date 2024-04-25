import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final StateProvider<DateTime> currentDateProvider;

  HomeViewModel() {
    currentDateProvider = StateProvider((ref) => DateTime.now());
  }
}
