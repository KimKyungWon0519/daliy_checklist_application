import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddViewModel {
  late final StateProvider<DateType> dateTypeProvider;
  late final StateProvider<SelectedDate> selectedDateProvider;

  String goalText = '';

  AddViewModel() {
    dateTypeProvider = StateProvider<DateType>((ref) => DateType.daily);
    selectedDateProvider =
        StateProvider<SelectedDate>((ref) => SelectedDate.empty());
  }
}
