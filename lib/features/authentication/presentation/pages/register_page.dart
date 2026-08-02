import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/social_login_row.dart';
import '../controllers/register_controller.dart';
import '../widgets/register_form_widget.dart';
import '../widgets/register_header_widget.dart';

/// Register Screen implementation with dummy registration redirect to Home screen.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _dobController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.copperAccent,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd / MM / yyyy').format(picked);
      _dobController.text = formattedDate;
      _formKey.currentState?.validate();
    }
  }

  void _handleSignUp(RegisterController controller, RegisterState state) {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      return;
    }

    if (!state.isAgreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.termsAgreementRequired),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    controller.register(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      dateOfBirth: _dobController.text,
    );
  }

  void _navigateToLogin() {
    if (context.canPop()) {
      context.pushReplacement(AppRoutes.login);
    } else {
      context.push(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RegisterState>(registerControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (next.isSuccess) {
        // Redirect to Home screen on successful dummy registration
        context.go(AppRoutes.home);
      }
    });

    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.welcome);
        }
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
                          child: Column(
                            children: [
                              const SizedBox(height: AppSpacing.sm),

                              // Header Block (Back Button & Title)
                              RegisterHeaderWidget(
                                onBackPressed: () {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.go(AppRoutes.welcome);
                                  }
                                },
                              ),

                              const SizedBox(height: AppSpacing.lg),

                              // Form Fields & Sign Up Button
                              RegisterFormWidget(
                                formKey: _formKey,
                                fullNameController: _fullNameController,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                confirmPasswordController:
                                    _confirmPasswordController,
                                dobController: _dobController,
                                isPasswordVisible: state.isPasswordVisible,
                                isConfirmPasswordVisible:
                                    state.isConfirmPasswordVisible,
                                isAgreedToTerms: state.isAgreedToTerms,
                                isLoading: state.isLoading,
                                onTogglePasswordVisibility:
                                    controller.togglePasswordVisibility,
                                onToggleConfirmPasswordVisibility:
                                    controller.toggleConfirmPasswordVisibility,
                                onToggleTermsAgreement:
                                    controller.toggleTermsAgreement,
                                onSelectDateOfBirth: () =>
                                    _selectDateOfBirth(context),
                                onSignUpPressed: () =>
                                    _handleSignUp(controller, state),
                              ),

                              const SizedBox(height: AppSpacing.xl),

                              // Social Login Buttons
                              const SocialLoginRow(),

                              const Spacer(),
                              const SizedBox(height: AppSpacing.lg),

                              // Bottom Navigation Link to Login Screen
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.alreadyHaveAccountPrompt,
                                    style: AppTypography.screenSubtitleStyle(),
                                  ),
                                  GestureDetector(
                                    onTap: _navigateToLogin,
                                    child: Text(
                                      AppStrings.signInLink,
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
      ),
    );
  }
}
