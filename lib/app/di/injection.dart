import 'package:get_it/get_it.dart';
import '../../core/services/logger_service.dart';
import '../../features/welcome/data/datasource/welcome_local_datasource.dart';
import '../../features/welcome/data/repository/welcome_repository_impl.dart';
import '../../features/welcome/domain/repository/welcome_repository.dart';
import '../../features/welcome/domain/usecase/get_welcome_config.dart';

final getIt = GetIt.instance;

/// Global dependency injection setup per instruction.md standards.
Future<void> setupDependencies() async {
  // Services
  getIt.registerLazySingleton<LoggerService>(() => LoggerService());

  // Data sources
  getIt.registerLazySingleton<WelcomeLocalDataSource>(
    () => WelcomeLocalDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<WelcomeRepository>(
    () => WelcomeRepositoryImpl(getIt<WelcomeLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton<GetWelcomeConfigUseCase>(
    () => GetWelcomeConfigUseCase(getIt<WelcomeRepository>()),
  );
}
