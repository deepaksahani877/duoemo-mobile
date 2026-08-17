import 'package:go_router/go_router.dart';
import '../../features/authentication/presentation/pages/create_new_password_page.dart';
import '../../features/authentication/presentation/pages/forgot_password_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/otp_verification_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/memories/presentation/pages/memories_page.dart';
import '../../features/welcome/presentation/pages/welcome_page.dart';

/// Routes registry for application navigation.
class AppRoutes {
  AppRoutes._();

  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String createNewPassword = '/create-new-password';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String memories = '/memories';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.otpVerification,
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return OtpVerificationPage(email: email);
      },
    ),
    GoRoute(
      path: AppRoutes.createNewPassword,
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return CreateNewPasswordPage(email: email);
      },
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: AppRoutes.memories,
      builder: (context, state) => const MemoriesPage(),
    ),
  ],
);
