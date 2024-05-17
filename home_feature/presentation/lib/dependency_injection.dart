import 'package:get_it/get_it.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/add_viewmodel.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

void initialize() {
  viewModelProvider = GetIt.instance;

  viewModelProvider.registerFactory<HomeViewModel>(() => HomeViewModel());
  viewModelProvider.registerFactory<AddViewModel>(() => AddViewModel());
}
