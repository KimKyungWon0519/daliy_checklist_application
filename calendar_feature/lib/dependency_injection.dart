import 'package:calendar_data/data.dart';
import 'package:calendar_domain/domain.dart';
import 'package:calendar_presentation/presentation.dart';

Future<void> initialize(final String directory) async {
  final TaskDatabase taskDatabase = TaskDatabase(directory);
  final TaskRepositoryImpl taskRepositoryImpl =
      TaskRepositoryImpl(taskDatabase: taskDatabase);
  final AddTask addTask = AddTask(taskRepository: taskRepositoryImpl);
  final GetTask getTask = GetTask(taskRepository: taskRepositoryImpl);
  final UpdateTask updateTask = UpdateTask(taskRepository: taskRepositoryImpl);

  viewModelProvider.registerFactory(
    () => EditViewModel(addTask: addTask),
  );
  viewModelProvider.registerFactory(() => CalendarViewModel(
        getTask: getTask,
        updateTask: updateTask,
      ));
}
