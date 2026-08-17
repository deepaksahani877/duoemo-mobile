import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_bottom_nav_widget.dart';
import '../widgets/home_header_widget.dart';
import '../widgets/live_connection_card_widget.dart';
import '../widgets/memory_card_widget.dart';
import '../widgets/quick_features_grid_widget.dart';
import '../widgets/streak_card_widget.dart';

/// Main home dashboard view.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final controller = ref.read(homeControllerProvider.notifier);
    final data = state.homeData;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Keep user on Home dashboard when on main screen
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSpacing.md),

                            // Top Header Block
                            HomeHeaderWidget(
                              userName: data?.userName ?? 'Suraj ✨',
                            ),

                            const SizedBox(height: AppSpacing.lg),

                            // Live Connection Card
                            LiveConnectionCardWidget(
                              partnerName: data?.partnerName ?? 'Neha',
                              isConnected: data?.isConnected ?? true,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            // Quick Features 6-Card Grid
                            QuickFeaturesGridWidget(
                              onLoveMessagesTap: () =>
                                  context.push(AppRoutes.chat),
                              onVoiceNotesTap: () =>
                                  context.push(AppRoutes.chat),
                              onGalleryTap: () =>
                                  context.push(AppRoutes.memories),
                            ),

                            const SizedBox(height: AppSpacing.md),

                            // Our Streak Card
                            StreakCardWidget(
                              streakDays: data?.streakDays ?? 23,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            // Memory of the Day Card
                            MemoryCardWidget(
                              memoryQuote: data?.memoryQuote ??
                                  'Every little moment with you becomes my favorite memory."',
                            ),

                            const SizedBox(height: AppSpacing.xl),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Floating Bottom Navigation Bar
              HomeBottomNavWidget(
                selectedIndex: state.selectedNavIndex,
                onTabSelected: (index) {
                  controller.selectNavTab(index);
                  if (index == 1) {
                    context.push(AppRoutes.memories);
                  } else if (index == 2) {
                    context.push(AppRoutes.chat);
                  }
                },
                onPulseFabPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Audio Pulse feature coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
