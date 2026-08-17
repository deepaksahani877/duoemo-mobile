import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../home/presentation/widgets/home_bottom_nav_widget.dart';
import '../controllers/memories_controller.dart';
import '../widgets/category_filter_bar_widget.dart';
import '../widgets/memories_header_widget.dart';
import '../widgets/memory_grid_card_widget.dart';

/// Main screen displaying the shared memories gallery.
class MemoriesPage extends ConsumerWidget {
  const MemoriesPage({super.key});

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoriesControllerProvider);
    final controller = ref.read(memoriesControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
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

                          // Header Bar
                          MemoriesHeaderWidget(
                            onSearchPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Search memories...'),
                                ),
                              );
                            },
                            onMorePressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Gallery options'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Category Filter Chips Bar
                          CategoryFilterBarWidget(
                            selectedCategory: state.selectedCategory,
                            onCategorySelected: controller.filterCategory,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // 3-Column Memories Media Grid with Floating Add Button Overlay
                          Expanded(
                            child: Stack(
                              children: [
                                GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xxl,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: AppSpacing.xs,
                                    mainAxisSpacing: AppSpacing.xs,
                                    childAspectRatio: 0.72,
                                  ),
                                  itemCount: state.items.length,
                                  itemBuilder: (context, index) {
                                    final item = state.items[index];
                                    return MemoryGridCardWidget(
                                      item: item,
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Opening memory ${item.id}',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                // Floating Add Memory Button (+)
                                Positioned(
                                  right: AppSpacing.sm,
                                  bottom: AppSpacing.lg,
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Add new memory...'),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(25),
                                            blurRadius: 16.0,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        size: 32.0,
                                        color: AppColors.copperAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Navigation Bar with active Memories tab (index 1)
              HomeBottomNavWidget(
                selectedIndex: 1,
                onTabSelected: (index) {
                  if (index == 0) {
                    context.go(AppRoutes.home);
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
