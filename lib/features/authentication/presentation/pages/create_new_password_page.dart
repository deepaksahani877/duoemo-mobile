import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/create_new_password_controller.dart';
import '../widgets/create_password_header_widget.dart';
import '../widgets/password_checklist_widget.dart';

/// Pixel-perfect Create New Password Page matching screenshot 3.
class CreateNewPasswordPage extends ConsumerStatefulWidget {
  final String email;

  const CreateNewPasswordPage({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<CreateNewPasswordPage> createState() =>
      _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState
    extends ConsumerState<CreateNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.forgotPassword);
    }
  }

  void _handleResetPassword(
    CreateNewPasswordController controller,
    CreateNewPasswordState state,
  ) {
    if (_formKey.currentState?.validate() ?? false) {
      if (!state.isPasswordStrong) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please meet all password requirements.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
      controller.resetPassword(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CreateNewPasswordState>(createNewPasswordControllerProvider,
        (previous, next) {
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
            content: Text(AppStrings.passwordResetSuccessMessage),
            backgroundColor: Colors.green,
          ),
        );
        context.go(AppRoutes.login);
      }
    });

    final state = ref.watch(createNewPasswordControllerProvider);
    final controller =
        ref.read(createNewPasswordControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed();
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: AppSpacing.sm),

                                // Top Header & Lock Graphic Icon
                                CreatePasswordHeaderWidget(
                                  onBackPressed: _onBackPressed,
                                ),

                                const SizedBox(height: AppSpacing.lg),

                                // Password Inputs Container Card
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.large,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(5),
                                        blurRadius: 16.0,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // New Password Field
                                      AppTextField(
                                        hintText: AppStrings.newPasswordLabel,
                                        controller: _passwordController,
                                        obscureText: !state.isPasswordVisible,
                                        prefixIcon: Icons.lock_outline_rounded,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            state.isPasswordVisible
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: AppColors.inputIcon,
                                          ),
                                          onPressed: controller
                                              .togglePasswordVisibility,
                                        ),
                                        onChanged: (val) => controller
                                            .updatePassword(val),
                                        validator:
                                            FormValidators.validatePassword,
                                      ),

                                      // Password Strength Bar & Label
                                      if (state.newPassword.isNotEmpty) ...[
                                        const SizedBox(height: AppSpacing.xs),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  AppRadius.pill,
                                                ),
                                                child: LinearProgressIndicator(
                                                  value: state.isPasswordStrong
                                                      ? 1.0
                                                      : (state.hasAtLeast8Chars
                                                          ? 0.6
                                                          : 0.3),
                                                  minHeight: 4.0,
                                                  backgroundColor:
                                                      AppColors.inputBorder,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    state.isPasswordStrong
                                                        ? AppColors
                                                            .strengthGreen
                                                        : AppColors
                                                            .copperAccent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.sm,
                                            ),
                                            Text(
                                              state.isPasswordStrong
                                                  ? AppStrings.strengthStrong
                                                  : 'Medium',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                color: state.isPasswordStrong
                                                    ? AppColors.strengthGreen
                                                    : AppColors.copperAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],

                                      const Divider(
                                        height: AppSpacing.lg,
                                        color: AppColors.subtleDivider,
                                      ),

                                      // Confirm Password Field
                                      AppTextField(
                                        hintText: AppStrings.confirmPasswordLabel,
                                        controller: _confirmPasswordController,
                                        obscureText:
                                            !state.isConfirmPasswordVisible,
                                        prefixIcon: Icons.lock_outline_rounded,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            state.isConfirmPasswordVisible
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: AppColors.inputIcon,
                                          ),
                                          onPressed: controller
                                              .toggleConfirmPasswordVisibility,
                                        ),
                                        onChanged: (val) => controller
                                            .updateConfirmPassword(val),
                                        validator: (val) =>
                                            FormValidators
                                                .validateConfirmPassword(
                                              val,
                                              _passwordController.text,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: AppSpacing.lg),

                                // Password Rules Checklist
                                PasswordChecklistWidget(
                                  hasAtLeast8Chars: state.hasAtLeast8Chars,
                                  hasUpperAndLower: state.hasUpperAndLower,
                                  hasNumberOrSpecialChar:
                                      state.hasNumberOrSpecialChar,
                                ),

                                const Spacer(),
                                const SizedBox(height: AppSpacing.xl),

                                // Reset Password Button
                                AppButton(
                                  label: AppStrings.resetPasswordButton,
                                  isLoading: state.isLoading,
                                  onPressed: () => _handleResetPassword(
                                    controller,
                                    state,
                                  ),
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
