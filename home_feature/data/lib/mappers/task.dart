import 'package:data/entites/task.dart' as Entity;
import 'package:domain/domain.dart' as Model;

extension DomainTaskMapper on Model.Task {
  Entity.Task toEntity() {
    return Entity.Task(
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
