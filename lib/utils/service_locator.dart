import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

GetIt serviceLocator = GetIt.instance;

void setupServiceLocatior() {
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
}
