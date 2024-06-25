import 'package:get_it/get_it.dart';
import 'package:item_tracker/core/routers/routes.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => AppNavigator());
}