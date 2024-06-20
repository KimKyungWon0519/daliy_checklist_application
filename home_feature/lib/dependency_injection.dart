import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

Future<void> initialize(final String directory) async {
  final TaskDatabase taskDatabase = TaskDatabase(directory);
  final TaskRepository taskRepository =
      TaskRepositoryImpl(taskDatabase: taskDatabase);
  final TaskHandlerRepository taskHandlerRepository =
      TaskHandlerRepositoryImpl();
  final GetTask getTask = GetTask(taskRepository: taskRepository);
  final TaskHandlerUseCase taskHandlerUseCase =
      TaskHandlerUseCase(taskHandlerRepository: taskHandlerRepository);

  List<Task> task = await getTask.getAllTasks();

  final HomeViewModel homeViewModel = HomeViewModel(
    getTask: getTask,
    taskHandlerUseCase: taskHandlerUseCase,
    initialTask: task,
  );

  viewModelProvider.registerFactory<HomeViewModel>(() => homeViewModel);
}
