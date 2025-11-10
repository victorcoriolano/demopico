import 'package:flutter/material.dart';

extension UiContextSize on BuildContext {
  //Properties
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;

  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get cardColor => Theme.of(this).cardColor;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;
  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;
  


  //Booleans
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;
  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;
  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;
  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  //Text Styles
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  TextStyle? get bodyExtraSmall =>
      bodySmall?.copyWith(fontSize: 10, height: 1.6, letterSpacing: .5);

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get dividerTextSmall => bodySmall?.copyWith(
      letterSpacing: 0.5, fontWeight: FontWeight.w700, fontSize: 12.0);

  TextStyle? get dividerTextLarge => bodySmall?.copyWith(
      letterSpacing: 1.5,
      fontWeight: FontWeight.w700,
      fontSize: 13.0,
      height: 1.23);


}
