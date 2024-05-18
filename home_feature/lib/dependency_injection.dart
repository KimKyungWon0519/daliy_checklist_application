import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/add_viewmodel.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

void initialize(final String directory) {
  viewModelProvider.registerFactory(
    () => AddViewModel(
      addTask: AddTask(
        taskRepository: TaskRepositoryImpl(
          taskDatabase: TaskDatabase(directory),
        ),
      ),
    ),
  );
  viewModelProvider.registerFactory(() => HomeViewModel());
}
