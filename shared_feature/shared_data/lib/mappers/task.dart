import 'package:shared_domain/shared_domain.dart' as Model;
import 'package:shared_data/entities/task.dart' as Entity;
import 'package:isar/isar.dart';

extension DomainTaskMapper on Model.Task {
  Entity.Task toEntity() {
    return Entity.Task(
      id: id ?? Isar.autoIncrement,
      goal: goal,
      startDate: selectedDate.startDate,
      endDate: selectedDate.endDate,
      colorCode: colorCode,
      isCompleted: isCompleted,
    );
  }
}

extension DataTaskMapper on Entity.Task {
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
