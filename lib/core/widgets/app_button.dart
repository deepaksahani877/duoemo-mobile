import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';

/// Reusable primary pill button per instruction.md standards.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 58.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.buttonPrimaryBg,
              AppColors.buttonPrimaryBgDark,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.buttonPrimaryBg.withAlpha(45),
              blurRadius: 16.0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            onTap: isLoading ? null : onPressed,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.buttonPrimaryText,
                        ),
                      ),
                    )
                  : Text(
                      label,
                      style: AppTypography.buttonPrimaryStyle(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
