import 'package:flutter/material.dart';

/// Extension methods on [BuildContext] to simplify access to theme and screen sizes.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}
