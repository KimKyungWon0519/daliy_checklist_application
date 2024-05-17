import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/presenters/viewmodels/add_viewmodel.dart';
import 'package:presentation/presenters/viewmodels/home_viewmodel.dart';

void initialize() {
  viewModelProvider.registerFactory(() => AddViewModel());
  viewModelProvider.registerFactory(() => HomeViewModel());
}
