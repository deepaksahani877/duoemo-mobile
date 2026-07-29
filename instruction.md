# Flutter AI Development Instructions

> **Purpose:**
> This document defines mandatory engineering standards for AI-generated Flutter code. Every feature, screen, module, and service must follow these rules unless explicitly overridden.

---

# Primary Goals

Every Flutter application must be:

* Maintainable
* Scalable
* Testable
* Modular
* Readable
* Extensible
* Backend Ready
* Localization Ready
* Theme Ready
* Platform Independent
* Performance Optimized

The generated code should be production-ready and suitable for long-term maintenance.

---

# General Principles

## Always

* Follow SOLID principles.
* Follow Clean Architecture.
* Follow DRY (Don't Repeat Yourself).
* Follow KISS (Keep It Simple).
* Follow Separation of Concerns.
* Follow Composition over Inheritance.
* Prefer immutable classes.
* Prefer stateless widgets whenever possible.
* Keep widgets small.
* Write self-documenting code.
* Use meaningful naming.

---

# Preferred Project Architecture

```
lib/

    app/
        app.dart
        router/
        theme/
        localization/
        constants/
        di/

    core/
        api/
        network/
        errors/
        utils/
        extensions/
        services/
        widgets/
        constants/
        logger/

    features/

        authentication/

            data/
                datasource/
                repository/
                model/

            domain/
                entity/
                repository/
                usecase/

            presentation/
                pages/
                widgets/
                controllers/

    shared/
        widgets/
        models/
        components/

    generated/
```

Each feature must be completely isolated.

Features should never directly depend on another feature.

---

# Clean Architecture

Every feature must contain:

* Presentation
* Domain
* Data

## Presentation

Contains only:

* UI
* State Management
* Navigation

Must NOT contain:

* API logic
* Database logic
* Business logic

---

## Domain

Contains:

* Entities
* UseCases
* Repository Contracts

Domain must never depend on Flutter.

---

## Data

Contains:

* DTO Models
* API Calls
* Local Storage
* Repository Implementations

---

# Dependency Injection

Dependency Injection is mandatory.

Use:

* get_it
* injectable (recommended)

Never instantiate services manually inside widgets.

Bad

```dart
final api = ApiService();
```

Good

```dart
final api = getIt<ApiService>();
```

Every dependency should be registered in one place.

---

# State Management

Preferred order

1. Riverpod
2. Bloc
3. Provider (only for small apps)

Never use:

```
setState()
```

for complex business logic.

Business logic belongs inside controllers/notifiers.

---

# Folder Structure Rules

Never create folders like

```
helpers/
misc/
utils2/
new_folder/
```

Every folder must have a clear responsibility.

---

# Widget Rules

Every widget should have one responsibility.

If widget exceeds around 200 lines, split it.

If build() becomes large, extract widgets.

Avoid deeply nested widgets.

Prefer reusable widgets.

---

# Reusable Components

Never duplicate UI.

Create reusable components for:

* Buttons
* Cards
* Dialogs
* Bottom Sheets
* Text Fields
* Empty States
* Error Views
* Loading Views
* Avatar
* Image Widgets
* List Items
* Search Bars

Shared widgets belong in

```
shared/widgets
```

---

# String Resources

Never hardcode strings.

Bad

```dart
Text("Login")
```

Good

```dart
context.l10n.login
```

or

```dart
AppStrings.login
```

Every string must come from localization.

---

# Localization

Localization must be configured from day one.

Use

```
flutter_localizations
intl
```

No hardcoded language.

Support:

* English
* Easy future expansion

Every text must be localizable.

---

# Theme Support

Theme must never be hardcoded.

Support:

* Light
* Dark
* Custom themes

Every widget should use

```dart
Theme.of(context)
```

or

```dart
context.colorScheme
```

Never

```dart
Colors.blue
```

inside widgets.

---

# Color Scheme

Maintain centralized colors.

Example

```
AppColors
```

or

```
ColorScheme
```

Never duplicate colors.

---

# Typography

Centralize typography.

Use

```
ThemeData.textTheme
```

Avoid inline font sizes.

---

# Dimensions

Create reusable constants.

Example

```
AppSpacing.small

AppSpacing.medium

AppSpacing.large
```

Avoid magic numbers.

---

# Icons

Centralize icons.

Avoid random icon usage.

---

# Assets

Keep assets organized.

```
assets/

    images/
    icons/
    animations/
    fonts/
```

Never reference asset paths directly.

Use generated accessors (e.g., `flutter_gen`).

---

# Networking

Networking layer must be completely reusable.

Structure

```
ApiClient

ApiService

Endpoints

ApiResponse

ApiException
```

---

# Base URL

Never hardcode URLs.

Example

```dart
class ApiConfig {
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://example.com/api',
  );
}
```

Allow environment-specific overrides (development, staging, production).

---

# API Endpoints

Never concatenate strings throughout the app.

Bad

```dart
"/users/login"
```

Good

```dart
ApiEndpoints.login
```

Example

```dart
class ApiEndpoints {
  static const login = "/auth/login";
  static const profile = "/user/profile";
}
```

---

# HTTP Client

Preferred

```
dio
```

Use:

* Interceptors
* Retry
* Timeout
* Logging (debug only)
* Auth interceptor
* Refresh token interceptor

---

# Repository Pattern

Presentation

↓

Repository Interface

↓

Repository Implementation

↓

Datasource

↓

API

Never call API directly from UI.

---

# DTO Models

Use

```
json_serializable
```

Avoid manual parsing.

---

# Error Handling

Never swallow exceptions.

Create:

```
Failure

ApiFailure

CacheFailure

ValidationFailure
```

Return typed results (e.g., `Either`, `Result`, or sealed classes) instead of throwing across layers where appropriate.

---

# Logging

Use structured logging.

Never use

```dart
print()
```

Use

```
logger
```

Disable verbose logs in release mode.

---

# Environment

Support

```
Development

Testing

Staging

Production
```

Use environment configuration.

---

# Storage

Use

```
shared_preferences
```

for simple preferences.

Use

```
flutter_secure_storage
```

for tokens.

Avoid storing sensitive information in plain storage.

---

# Database

If offline support is required:

Preferred

```
drift
```

Alternative

```
isar
```

---

# Navigation

Preferred

```
go_router
```

Never hardcode routes.

Use typed routing where possible.

---

# Testing

Every layer should be testable.

Required:

* Unit Tests
* Widget Tests
* Repository Tests

Mock external dependencies.

Use dependency injection for testability.

---

# Performance

Avoid unnecessary rebuilds.

Use:

* const constructors
* lazy loading
* pagination
* caching
* image optimization

Avoid expensive work inside `build()`.

---

# Async

Never ignore Futures.

Use proper async handling.

Cancel subscriptions.

Dispose controllers.

---

# Null Safety

Use Dart null safety correctly.

Avoid force unwrap (`!`) unless absolutely guaranteed.

---

# Code Generation

Preferred

```
build_runner
```

Generate:

* JSON
* DI
* Routes (if applicable)
* Asset accessors

Never edit generated files.

---

# Platform Support

The application must prioritize pure Dart implementations.

Rules:

1. Use Dart-only libraries whenever possible.
2. Use Flutter-supported plugins with active maintenance.
3. Write platform-specific code only when no Dart solution exists.
4. Encapsulate platform-specific implementations behind interfaces.
5. Never scatter platform channels throughout the codebase.

Supported platforms:

* Android
* iOS
* Windows
* macOS
* Linux
* Web

---

# Library Selection Policy

Only use:

* Official Flutter packages
* Official Dart packages
* Highly maintained community packages
* Well-documented packages
* Packages with active releases
* Packages with strong community adoption

Avoid:

* Unmaintained packages
* Experimental packages for production
* Abandoned repositories
* Packages with poor documentation

Always prefer long-term ecosystem stability over novelty.

---

# Preferred Libraries

## State Management

* flutter_riverpod

## Dependency Injection

* get_it
* injectable

## Networking

* dio

## JSON

* json_serializable

## Immutable Models

* freezed

## Logging

* logger

## Routing

* go_router

## Localization

* intl
* flutter_localizations

## Secure Storage

* flutter_secure_storage

## Preferences

* shared_preferences

## Database

* drift
* isar

## Testing

* flutter_test
* mocktail

## Image Caching

* cached_network_image

## SVG

* flutter_svg

## Shimmer

* shimmer

## Connectivity

* connectivity_plus

## Device Info

* device_info_plus

## Package Info

* package_info_plus

## URL Launcher

* url_launcher

## Permissions

* permission_handler

---

# Reusability Rules

If code is repeated more than once:

Extract it.

If UI repeats:

Create a reusable widget.

If logic repeats:

Create a reusable service.

If validation repeats:

Create reusable validators.

If styles repeat:

Move them into theme resources.

---

# Documentation

Every public class should include documentation comments.

Complex logic should include concise comments explaining *why*, not *what*.

Avoid redundant comments.

---

# Security

Never:

* Hardcode API keys
* Hardcode secrets
* Hardcode tokens
* Expose private endpoints

Use secure configuration and environment variables.

---

# AI Code Generation Rules

When generating Flutter code, always:

* Generate complete production-ready code.
* Follow this architecture.
* Keep files focused on a single responsibility.
* Prefer composition over inheritance.
* Write idiomatic Dart.
* Use null safety.
* Use immutable models where appropriate.
* Avoid unnecessary comments.
* Prefer dependency injection.
* Keep business logic out of widgets.
* Never duplicate code.
* Make every feature testable.
* Ensure backend integration can be swapped by changing configuration only.
* Ensure localization and theming require minimal changes to extend.
* Prefer pure Dart implementations and use platform-specific code only when absolutely necessary.
* Use only highly maintained, community-supported libraries.
* Explain any architectural trade-offs when deviating from these standards.

---

# Definition of Done

A feature is considered complete only if it:

* Follows Clean Architecture.
* Uses dependency injection.
* Has no duplicated logic.
* Uses reusable widgets.
* Uses centralized colors.
* Uses centralized typography.
* Uses centralized spacing.
* Uses localization for all user-facing text.
* Supports theming.
* Uses typed models.
* Uses repository pattern.
* Is backend-ready.
* Has proper error handling.
* Is testable.
* Avoids hardcoded configuration.
* Uses production-quality, well-maintained dependencies.
* Compiles without warnings or analyzer issues.
