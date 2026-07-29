import 'package:flutter/material.dart';
import '../../../../app/constants/app_assets.dart';

/// Modular illustration widget for the Welcome screen.
class WelcomeIllustrationWidget extends StatelessWidget {
  const WelcomeIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 380,
          maxHeight: 380,
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
