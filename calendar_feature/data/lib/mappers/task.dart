import 'package:shared_feature/shared_feature.dart' as SharedFeature;
import 'package:domain/domain.dart' as Model;
import 'package:isar/isar.dart';

extension DomainTaskMapper on Model.Task {
  SharedFeature.Task toEntity() {
    return SharedFeature.Task(
      id: id ?? Isar.autoIncrement,
      goal: goal,
      startDate: selectedDate.startDate,
      endDate: selectedDate.endDate,
      colorCode: colorCode,
      isCompleted: isCompleted,
    );
  }
}

extension DataTaskMapper on SharedFeature.Task {
  Model.Task toModel() {
    return Model.Task(
      id: id,
      goal: goal,
      selectedDate: Model.SelectedDate(
        startDate: startDate,
        endDate: endDate,
      ),
      colorCode: colorCode,
      isCompleted: isCompleted,
    );
  }
}
