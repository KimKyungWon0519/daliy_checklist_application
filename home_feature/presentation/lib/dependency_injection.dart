import 'package:get_it/get_it.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

void initialize() {
  viewModelProvider = GetIt.instance;

  viewModelProvider.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
}
