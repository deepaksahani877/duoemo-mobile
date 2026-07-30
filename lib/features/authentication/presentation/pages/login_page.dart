import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/social_login_row.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/login_header_widget.dart';

/// Login Screen implementation with robust form validation following Clean Architecture.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn(LoginController controller) {
    if (_formKey.currentState?.validate() ?? false) {
      controller.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in successful! Welcome back.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppConstants.maxContentWidth,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: AppSpacing.md),

                            // Top Header Block (Illustration, Logo, Tagline)
                            const LoginHeaderWidget(),

                            const SizedBox(height: AppSpacing.lg),

                            // Form Block (Inputs, Validation & Sign In Button)
                            LoginFormWidget(
                              formKey: _formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              isPasswordVisible: state.isPasswordVisible,
                              isLoading: state.isLoading,
                              onTogglePasswordVisibility:
                                  controller.togglePasswordVisibility,
                              onForgotPasswordPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password reset link sent!'),
                                  ),
                                );
                              },
                              onSignInPressed: () => _handleSignIn(controller),
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            // Social Login Row
                            const SocialLoginRow(),

                            const Spacer(),
                            const SizedBox(height: AppSpacing.lg),

                            // Bottom Navigation Link to Register Screen
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  AppStrings.dontHaveAccountPrompt,
                                  style: AppTypography.screenSubtitleStyle(),
                                ),
                                GestureDetector(
                                  onTap: () => context.go(AppRoutes.register),
                                  child: Text(
                                    AppStrings.signUpLink,
                                    style: AppTypography.linkStyle(),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: AppSpacing.lg),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
