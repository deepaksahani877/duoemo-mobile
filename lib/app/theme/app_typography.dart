import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography definitions matching the pixel-perfect design.
class AppTypography {
  AppTypography._();

  /// Elegant serif font for logo/branding: "d u o e m o"
  static TextStyle logoStyle({Color color = AppColors.textPrimary}) {
    return GoogleFonts.cormorantGaramond(
      fontSize: 42.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 10.0,
      color: color,
      height: 1.1,
    );
  }

  /// Small all-caps subtitle style: "SHARED MEMORIES."
  static TextStyle taglineStyle({Color color = AppColors.textSecondary}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 2.8,
      color: color,
      height: 1.6,
    );
  }

  /// Poetic quote text style: "Where distance ends,\nconnection begins."
  static TextStyle quoteStyle({Color color = AppColors.textPrimary}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
      color: color,
      height: 1.45,
    );
  }

  /// Primary button label style
  static TextStyle buttonPrimaryStyle({Color color = AppColors.buttonPrimaryText}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: color,
    );
  }

  /// Secondary button text style
  static TextStyle buttonSecondaryStyle({Color color = AppColors.buttonSecondaryText}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
      color: color,
    );
  }
}
