import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duoemo/app/di/injection.dart';
import 'package:duoemo/app/localization/app_strings.dart';
import 'package:duoemo/core/services/logger_service.dart';
import 'package:duoemo/features/authentication/presentation/pages/login_page.dart';
import 'package:duoemo/features/authentication/presentation/pages/register_page.dart';
import 'package:duoemo/features/welcome/presentation/pages/welcome_page.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Welcome screen renders correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    if (!getIt.isRegistered<LoggerService>()) {
      await setupDependencies();
    }

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WelcomePage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(AppStrings.createDuoButton), findsOneWidget);
    expect(find.text(AppStrings.alreadyHaveAccountButton), findsOneWidget);
  });

  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    if (!getIt.isRegistered<LoggerService>()) {
      await setupDependencies();
    }

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(AppStrings.welcomeBackHeading), findsOneWidget);
    expect(find.text(AppStrings.signInButton), findsOneWidget);
  });

  testWidgets('Register screen renders correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    if (!getIt.isRegistered<LoggerService>()) {
      await setupDependencies();
    }

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(AppStrings.createAccountHeading), findsOneWidget);
    expect(find.text(AppStrings.signUpButton), findsOneWidget);
  });
}
