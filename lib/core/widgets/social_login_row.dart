import 'package:flutter/material.dart';
import '../../app/localization/app_strings.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';

/// Reusable social login buttons row per instruction.md standards.
class SocialLoginRow extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final VoidCallback? onEmailPressed;

  const SocialLoginRow({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.onEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Divider with center text
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.subtleDivider,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                AppStrings.orContinueWith,
                style: AppTypography.dividerTextStyle(),
              ),
            ),
            const Expanded(
              child: Divider(
                color: AppColors.subtleDivider,
                thickness: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Social Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              onPressed: onGooglePressed,
              child: const _GoogleLogoWidget(),
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              onPressed: onApplePressed,
              child: const Icon(
                Icons.apple,
                size: 26.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              onPressed: onEmailPressed,
              child: const Icon(
                Icons.mail_outline_rounded,
                size: 22.0,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const _SocialButton({
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.0,
      height: 52.0,
      decoration: BoxDecoration(
        color: AppColors.socialButtonBg,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: AppColors.socialButtonBorder,
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          onTap: onPressed,
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// Custom painter rendering the 4-color Google 'G' icon pixel-perfectly.
class _GoogleLogoWidget extends StatelessWidget {
  const _GoogleLogoWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.0,
      height: 22.0,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Offset center = Offset(w / 2, h / 2);
    final double radius = w / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.2;

    // Red Arc (top)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      3.8,
      1.7,
      false,
      paint,
    );

    // Yellow Arc (left-bottom)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      2.3,
      1.5,
      false,
      paint,
    );

    // Green Arc (bottom-right)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      0.6,
      1.7,
      false,
      paint,
    );

    // Blue Arc & Bar (right)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      -0.5,
      1.1,
      false,
      paint,
    );

    final Paint fillBlue = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(w / 2 - 1, h / 2 - 2.1, w / 2 + 1, 4.2),
      fillBlue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
