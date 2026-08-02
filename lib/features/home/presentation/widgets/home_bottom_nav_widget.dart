import 'package:flutter/material.dart';
import '../../../../app/localization/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Modular floating bottom navigation bar for the Home screen.
class HomeBottomNavWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback? onPulseFabPressed;

  const HomeBottomNavWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.onPulseFabPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 24.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _NavItem(
              icon: Icons.home_rounded,
              label: AppStrings.navHome,
              isSelected: selectedIndex == 0,
              onTap: () => onTabSelected(0),
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.image_outlined,
              label: AppStrings.navMemories,
              isSelected: selectedIndex == 1,
              onTap: () => onTabSelected(1),
            ),
          ),

          // Center Audio Pulse Button
          GestureDetector(
            onTap: onPulseFabPressed,
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF9F0E6),
                border: Border.all(
                  color: AppColors.copperAccent.withAlpha(40),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.copperAccent.withAlpha(25),
                    blurRadius: 10.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.graphic_eq_rounded,
                size: 26.0,
                color: AppColors.copperAccent,
              ),
            ),
          ),

          Expanded(
            child: _NavItem(
              icon: Icons.chat_bubble_outline_rounded,
              label: AppStrings.navChat,
              isSelected: selectedIndex == 2,
              onTap: () => onTabSelected(2),
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.person_outline_rounded,
              label: AppStrings.navProfile,
              isSelected: selectedIndex == 3,
              onTap: () => onTabSelected(3),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.copperAccent : AppColors.textSubtle;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22.0,
            color: color,
          ),
          const SizedBox(height: 3.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
