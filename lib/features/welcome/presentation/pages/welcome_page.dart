import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../controllers/welcome_controller.dart';
import '../widgets/welcome_actions_widget.dart';
import '../widgets/welcome_illustration_widget.dart';
import '../widgets/welcome_text_widget.dart';

/// Pixel-perfect & responsive Welcome Screen supporting all screen sizes.
class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(welcomeControllerProvider);
    final controller = ref.read(welcomeControllerProvider.notifier);

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
                            const Spacer(flex: 1),

                            // Illustration Artwork (Scales dynamically)
                            const WelcomeIllustrationWidget(),

                            const SizedBox(height: AppSpacing.md),

                            // Brand & Typography Block
                            const WelcomeTextWidget(),

                            const Spacer(flex: 2),

                            // Bottom Action Buttons
                            WelcomeActionsWidget(
                              onCreateDuoPressed: controller.handleCreateDuo,
                              onAlreadyHaveAccountPressed:
                                  controller.handleAlreadyHaveAccount,
                              isLoading: state.isLoading,
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
