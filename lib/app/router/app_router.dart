import 'package:go_router/go_router.dart';
import '../../features/welcome/presentation/pages/welcome_page.dart';

/// Centralized route definitions per instruction.md standards.
class AppRoutes {
  AppRoutes._();

  static const String welcome = '/';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
  ],
);
