import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../controllers/otp_verification_controller.dart';
import '../widgets/otp_header_widget.dart';
import '../widgets/otp_input_widget.dart';

/// Pixel-perfect OTP Verification Page matching screenshot 2.
class OtpVerificationPage extends ConsumerWidget {
  final String email;

  const OtpVerificationPage({
    super.key,
    required this.email,
  });

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.forgotPassword);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayEmail =
        email.isNotEmpty ? email : AppStrings.dummyUserEmail;

    ref.listen<OtpVerificationState>(otpVerificationControllerProvider,
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
        context.pushReplacement(
          AppRoutes.createNewPassword,
          extra: displayEmail,
        );
      }
    });

    final state = ref.watch(otpVerificationControllerProvider);
    final controller =
        ref.read(otpVerificationControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed(context);
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

                              // Top Header & Shield Graphic Icon
                              OtpHeaderWidget(
                                email: displayEmail,
                                onBackPressed: () => _onBackPressed(context),
                              ),

                              const SizedBox(height: AppSpacing.xl),

                              // 6-Digit OTP Input Boxes
                              OtpInputWidget(
                                onChanged: (code) {
                                  controller.updateOtp(code);
                                  if (code.length == 6 &&
                                      !state.isLoading &&
                                      !state.isSuccess) {
                                    controller.verifyOtp(displayEmail);
                                  }
                                },
                              ),

                              const SizedBox(height: AppSpacing.xxl),

                              // Resend Code Section
                              Column(
                                children: [
                                  Text(
                                    AppStrings.didntReceiveCodePrompt,
                                    style:
                                        AppTypography.screenSubtitleStyle(),
                                  ),
                                  const SizedBox(height: AppSpacing.xxs),
                                  GestureDetector(
                                    onTap: state.canResend
                                        ? () => controller
                                            .resendOtp(displayEmail)
                                        : null,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppStrings.resendCodeIn,
                                            style: AppTypography
                                                .screenSubtitleStyle(),
                                          ),
                                          TextSpan(
                                            text: state.canResend
                                                ? 'Resend Now'
                                                : state.formattedTimer,
                                            style: AppTypography.linkStyle()
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),
                              const SizedBox(height: AppSpacing.lg),

                              // Bottom Security Info Banner Card
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: AppColors.bannerBg,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.large,
                                  ),
                                  border: Border.all(
                                    color:
                                        AppColors.copperAccent.withAlpha(20),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppColors.copperAccent
                                              .withAlpha(40),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.shield_outlined,
                                        size: 20.0,
                                        color: AppColors.copperAccent,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.securityBannerTitle,
                                            style: AppTypography
                                                .screenTitleStyle()
                                                .copyWith(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2.0),
                                          Text(
                                            AppStrings.securityBannerSub,
                                            style: AppTypography
                                                .screenSubtitleStyle()
                                                .copyWith(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
              );
            },
          ),
        ),
      ),
    );
  }
}
