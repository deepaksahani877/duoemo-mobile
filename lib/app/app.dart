import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/app_constants.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root application widget setting up Riverpod, Router, Theme & Localization.
class DuoemoApp extends StatelessWidget {
  const DuoemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: appRouter,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
      ),
    );
  }
}
