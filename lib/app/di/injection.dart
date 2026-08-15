import 'package:get_it/get_it.dart';
import '../../core/services/logger_service.dart';
import '../../features/authentication/data/datasource/auth_local_datasource.dart';
import '../../features/authentication/data/repository/auth_repository_impl.dart';
import '../../features/authentication/domain/repository/auth_repository.dart';
import '../../features/authentication/domain/usecase/login_usecase.dart';
import '../../features/authentication/domain/usecase/register_usecase.dart';
import '../../features/authentication/domain/usecase/request_password_reset_usecase.dart';
import '../../features/authentication/domain/usecase/reset_password_usecase.dart';
import '../../features/authentication/domain/usecase/verify_otp_usecase.dart';
import '../../features/chat/data/datasource/chat_local_datasource.dart';
import '../../features/chat/data/repository/chat_repository_impl.dart';
import '../../features/chat/domain/repository/chat_repository.dart';
import '../../features/chat/domain/usecase/get_chat_messages_usecase.dart';
import '../../features/chat/domain/usecase/send_message_usecase.dart';
import '../../features/home/data/datasource/home_local_datasource.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/repository/home_repository.dart';
import '../../features/home/domain/usecase/get_home_data_usecase.dart';
import '../../features/welcome/data/datasource/welcome_local_datasource.dart';
import '../../features/welcome/data/repository/welcome_repository_impl.dart';
import '../../features/welcome/domain/repository/welcome_repository.dart';
import '../../features/welcome/domain/usecase/get_welcome_config.dart';

final getIt = GetIt.instance;

/// Global dependency injection setup.
Future<void> setupDependencies() async {
  // Services
  if (!getIt.isRegistered<LoggerService>()) {
    getIt.registerLazySingleton<LoggerService>(() => LoggerService());
  }

  // Welcome Feature
  if (!getIt.isRegistered<WelcomeLocalDataSource>()) {
    getIt.registerLazySingleton<WelcomeLocalDataSource>(
      () => WelcomeLocalDataSourceImpl(),
    );
  }
  if (!getIt.isRegistered<WelcomeRepository>()) {
    getIt.registerLazySingleton<WelcomeRepository>(
      () => WelcomeRepositoryImpl(getIt<WelcomeLocalDataSource>()),
    );
  }
  if (!getIt.isRegistered<GetWelcomeConfigUseCase>()) {
    getIt.registerLazySingleton<GetWelcomeConfigUseCase>(
      () => GetWelcomeConfigUseCase(getIt<WelcomeRepository>()),
    );
  }

  // Authentication Feature
  if (!getIt.isRegistered<AuthLocalDataSource>()) {
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
    );
  }
  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthLocalDataSource>()),
    );
  }
  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<RegisterUseCase>()) {
    getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<RequestPasswordResetUseCase>()) {
    getIt.registerLazySingleton<RequestPasswordResetUseCase>(
      () => RequestPasswordResetUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<VerifyOtpUseCase>()) {
    getIt.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(getIt<AuthRepository>()),
    );
  }
  if (!getIt.isRegistered<ResetPasswordUseCase>()) {
    getIt.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt<AuthRepository>()),
    );
  }

  // Home Feature
  if (!getIt.isRegistered<HomeLocalDataSource>()) {
    getIt.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(),
    );
  }
  if (!getIt.isRegistered<HomeRepository>()) {
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<HomeLocalDataSource>()),
    );
  }
  if (!getIt.isRegistered<GetHomeDataUseCase>()) {
    getIt.registerLazySingleton<GetHomeDataUseCase>(
      () => GetHomeDataUseCase(getIt<HomeRepository>()),
    );
  }

  // Chat Feature
  if (!getIt.isRegistered<ChatLocalDataSource>()) {
    getIt.registerLazySingleton<ChatLocalDataSource>(
      () => ChatLocalDataSourceImpl(),
    );
  }
  if (!getIt.isRegistered<ChatRepository>()) {
    getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(getIt<ChatLocalDataSource>()),
    );
  }
  if (!getIt.isRegistered<GetChatMessagesUseCase>()) {
    getIt.registerLazySingleton<GetChatMessagesUseCase>(
      () => GetChatMessagesUseCase(getIt<ChatRepository>()),
    );
  }
  if (!getIt.isRegistered<SendMessageUseCase>()) {
    getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(getIt<ChatRepository>()),
    );
  }
}
