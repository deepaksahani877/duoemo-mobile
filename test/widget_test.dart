import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duoemo/app/di/injection.dart';
import 'package:duoemo/app/localization/app_strings.dart';
import 'package:duoemo/core/services/logger_service.dart';
import 'package:duoemo/features/welcome/presentation/pages/welcome_page.dart';
import 'package:duoemo/features/welcome/presentation/widgets/welcome_actions_widget.dart';
import 'package:duoemo/features/welcome/presentation/widgets/welcome_text_widget.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Welcome components render correctly smoke test',
      (WidgetTester tester) async {
    if (!getIt.isRegistered<LoggerService>()) {
      await setupDependencies();
    }

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WelcomeTextWidget(),
        ),
      ),
    );

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.taglineLine1), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 380,
              child: WelcomeActionsWidget(
                onCreateDuoPressed: () {},
                onAlreadyHaveAccountPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text(AppStrings.createDuoButton), findsOneWidget);
    expect(find.text(AppStrings.alreadyHaveAccountButton), findsOneWidget);
  });

  testWidgets('Full WelcomePage renders cleanly without error',
      (WidgetTester tester) async {
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

    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.text(AppStrings.createDuoButton), findsOneWidget);
  });
}
