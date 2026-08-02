import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duoemo/app/di/injection.dart';
import 'package:duoemo/app/localization/app_strings.dart';
import 'package:duoemo/core/services/logger_service.dart';
import 'package:duoemo/core/utils/form_validators.dart';
import 'package:duoemo/features/authentication/presentation/pages/login_page.dart';
import 'package:duoemo/features/authentication/presentation/pages/register_page.dart';
import 'package:duoemo/features/home/presentation/pages/home_page.dart';
import 'package:duoemo/features/welcome/presentation/pages/welcome_page.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Form Validation Unit Tests', () {
    test('Email validation rules', () {
      expect(FormValidators.validateEmail(''), AppStrings.emailRequired);
      expect(FormValidators.validateEmail('invalid-email'), AppStrings.emailInvalid);
      expect(FormValidators.validateEmail('user@example.com'), null);
    });

    test('Password validation rules', () {
      expect(FormValidators.validatePassword(''), AppStrings.passwordRequired);
      expect(FormValidators.validatePassword('123'), AppStrings.passwordTooShort);
      expect(FormValidators.validatePassword('secret123'), null);
    });

    test('Full Name validation rules', () {
      expect(FormValidators.validateFullName(''), AppStrings.fullNameRequired);
      expect(FormValidators.validateFullName('A'), AppStrings.fullNameTooShort);
      expect(FormValidators.validateFullName('Jane Doe'), null);
    });

    test('Confirm Password validation rules', () {
      expect(
        FormValidators.validateConfirmPassword('', 'pass123'),
        AppStrings.confirmPasswordRequired,
      );
      expect(
        FormValidators.validateConfirmPassword('pass456', 'pass123'),
        AppStrings.passwordsDoNotMatch,
      );
      expect(
        FormValidators.validateConfirmPassword('pass123', 'pass123'),
        null,
      );
    });
  });

  group('Widget Render Tests', () {
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

    testWidgets('Home screen renders correctly', (WidgetTester tester) async {
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
            home: HomePage(),
          ),
        ),
      );
      await tester.pump();

      expect(find.text(AppStrings.goodEveningGreeting), findsOneWidget);
      expect(find.text(AppStrings.liveConnectionTitle), findsOneWidget);
      expect(find.text(AppStrings.ourStreakTitle), findsOneWidget);
    });
  });
}
