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

/// Pixel-perfect Register Screen implementation following Clean Architecture rules.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);

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
                              onSignUpPressed: () {
                                controller.register(
                                  fullName: _fullNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  dateOfBirth: _dobController.text,
                                );
                              },
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            // Social Login Buttons
                            const SocialLoginRow(),

                            const Spacer(),
                            const SizedBox(height: AppSpacing.lg),

                            // Bottom Navigation Link to Login Screen (Wrap for small screens)
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyHaveAccountPrompt,
                                  style: AppTypography.screenSubtitleStyle(),
                                ),
                                GestureDetector(
                                  onTap: () => context.go(AppRoutes.login),
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
    );
  }
}
