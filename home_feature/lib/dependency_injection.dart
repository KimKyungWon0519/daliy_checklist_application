import 'package:data/data.dart' as Data;
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

Future<void> initialize(final String directory) async {
  final Data.TaskDatabase taskDatabase = Data.TaskDatabase(directory);
  final Data.TaskRepositoryImpl taskRepositoryImpl =
      Data.TaskRepositoryImpl(taskDatabase: taskDatabase);
  final AddTask addTask = AddTask(taskRepository: taskRepositoryImpl);
  final GetTask getTask = GetTask(taskRepository: taskRepositoryImpl);

  viewModelProvider.registerFactory(
    () => AddViewModel(addTask: addTask),
  );
  viewModelProvider.registerFactory(() => HomeViewModel(getTask: getTask));
}
