import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/forgot_password_controller.dart';
import '../widgets/forgot_password_header_widget.dart';

/// Pixel-perfect Forgot Password Page matching screenshot 1.
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendResetLink(ForgotPasswordController controller) {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      controller.sendResetLink(email);
    }
  }

  void _navigateToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ForgotPasswordState>(forgotPasswordControllerProvider,
        (previous, next) {
      if (next.errorMessage != null &&
          (previous == null || previous.errorMessage != next.errorMessage)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (next.isSuccess &&
          (previous == null || !previous.isSuccess)) {
        final email = _emailController.text.trim();
        context.pushReplacement(
          AppRoutes.otpVerification,
          extra: email.isEmpty ? AppStrings.dummyUserEmail : email,
        );
      }
    });

    final state = ref.watch(forgotPasswordControllerProvider);
    final controller = ref.read(forgotPasswordControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _navigateToLogin();
      },
      child: Scaffold(
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
                          child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                const SizedBox(height: AppSpacing.sm),

                                // Top Header & Branding
                                ForgotPasswordHeaderWidget(
                                  onBackPressed: _navigateToLogin,
                                ),

                                const SizedBox(height: AppSpacing.xl),

                                // Email Input Field
                                AppTextField(
                                  hintText: AppStrings.emailPlaceholder,
                                  controller: _emailController,
                                  prefixIcon: Icons.mail_outline_rounded,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: FormValidators.validateEmail,
                                ),

                                const SizedBox(height: AppSpacing.xl),

                                // Send Reset Link Button
                                AppButton(
                                  label: AppStrings.sendResetLinkButton,
                                  isLoading: state.isLoading,
                                  onPressed: () =>
                                      _handleSendResetLink(controller),
                                ),

                                const Spacer(),
                                const SizedBox(height: AppSpacing.lg),

                                // Bottom Navigation Link to Login
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment:
                                      WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.rememberPasswordPrompt,
                                      style: AppTypography
                                          .screenSubtitleStyle(),
                                    ),
                                    GestureDetector(
                                      onTap: _navigateToLogin,
                                      child: Text(
                                        AppStrings.loginLink,
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
