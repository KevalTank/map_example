import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:map_example/initializer.config.dart';

final getIt = GetIt.instance;

// Configure the dependencies
@InjectableInit(
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();
}
