import 'package:get_it/get_it.dart';
import 'package:thetreeapptest/app/utils/network.dart';

GetIt getIt = GetIt.I;

void setupDependencies() {
  getIt.registerLazySingleton(() => Network());
}