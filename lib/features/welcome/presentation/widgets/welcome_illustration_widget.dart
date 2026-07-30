import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';

/// Modular illustration widget that dynamically scales with available screen height.
class WelcomeIllustrationWidget extends StatelessWidget {
  const WelcomeIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Scale maximum illustration height based on total screen height
    final double maxIllustrationHeight = (screenHeight * 0.38).clamp(200.0, 380.0);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 380,
          maxHeight: maxIllustrationHeight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            AppAssets.welcomeIllustration,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
