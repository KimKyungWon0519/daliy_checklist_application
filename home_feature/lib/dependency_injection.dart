import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

void initialize(final String directory) {
  final TaskDatabase taskDatabase = TaskDatabase(directory);
  final TaskRepository taskRepository =
      TaskRepositoryImpl(taskDatabase: taskDatabase);
  final GetTask getTask = GetTask(taskRepository: taskRepository);
  final HomeViewModel homeViewModel = HomeViewModel(getTask: getTask);

  viewModelProvider.registerFactory<HomeViewModel>(() => homeViewModel);
}
