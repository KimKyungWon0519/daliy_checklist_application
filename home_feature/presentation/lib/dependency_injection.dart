import 'package:get_it/get_it.dart';
import 'package:home_feature/constants/app_constants.dart';
import 'package:home_feature/presenters/viewmodels/add_viewmodel.dart';
import 'package:home_feature/presenters/viewmodels/home_viewmodel.dart';

void initialize() {
  viewModelProvider = GetIt.instance;

  viewModelProvider.registerFactory<HomeViewModel>(() => HomeViewModel());
  viewModelProvider.registerFactory<AddViewModel>(() => AddViewModel());
}
