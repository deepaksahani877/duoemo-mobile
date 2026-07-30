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

/// Pixel-perfect Login Screen implementation following Clean Architecture rules.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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

  @override
  Widget build(BuildContext context) {
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

                            // Form Block (Inputs & Sign In Button)
                            LoginFormWidget(
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
                              onSignInPressed: () {
                                controller.login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              },
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            // Social Login Row
                            const SocialLoginRow(),

                            const Spacer(),
                            const SizedBox(height: AppSpacing.lg),

                            // Bottom Navigation Link to Register Screen (Wrap for small screens)
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
