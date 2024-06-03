import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taska/utils/custom_colors.dart';

const String kFOpenSans = 'OpenSans';
const String kFConstantia = 'Constantia';

const Color _kLightPrimary = Color(0xFF36693E);
const Color _kDarkPrimary = Color(0xFF9CD49F);

const Color _kLightBg = Color(0xFFF7FBF2);
const Color _kDarkBg = Color(0xFF101510);

const Color _kLightTextColor = Color(0xFF181D18);
const Color _kDarkTextColor = Color(0xFFE0E4DB);

const ColorScheme _kLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: _kLightPrimary,
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFB7F1BA),
  onPrimaryContainer: Color(0xFF002109),
  secondary: Color(0xFF7E570F),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDDB1),
  onSecondaryContainer: Color(0xFF291800),
  tertiary: Color(0xFF2B638B),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFCCE5FF),
  onTertiaryContainer: Color(0xFF001E31),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF7FBF2),
  onBackground: Color(0xFF181D18),
  surface: Color(0xFFF7FBF2),
  onSurface: Color(0xFF181D18),
  surfaceVariant: Color(0xFFDDE5D9),
  onSurfaceVariant: Color(0xFF424941),
  outline: Color(0xFF727970),
  outlineVariant: Color(0xFFC1C9BE),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF2D322C),
  onInverseSurface: Color(0xFFEEF2EA),
  inversePrimary: Color(0xFF9CD49F),
  surfaceTint: _kLightPrimary,
);
const ColorScheme _kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: _kDarkPrimary,
  onPrimary: Color(0xFF003914),
  primaryContainer: Color(0xFF1C5128),
  onPrimaryContainer: Color(0xFFB7F1BA),
  secondary: Color(0xFFF3BD6E),
  onSecondary: Color(0xFF442B00),
  secondaryContainer: Color(0xFF614000),
  onSecondaryContainer: Color(0xFFFFDDB1),
  tertiary: Color(0xFF98CCF9),
  onTertiary: Color(0xFF003350),
  tertiaryContainer: Color(0xFF054B71),
  onTertiaryContainer: Color(0xFFCCE5FF),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF101510),
  onBackground: Color(0xFFE0E4DB),
  surface: Color(0xFF101510),
  onSurface: Color(0xFFE0E4DB),
  surfaceVariant: Color(0xFF424941),
  onSurfaceVariant: Color(0xFFC1C9BE),
  outline: Color(0xFF8B9389),
  outlineVariant: Color(0xFF424941),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE0E4DB),
  onInverseSurface: Color(0xFF2D322C),
  inversePrimary: Color(0xFF36693E),
  surfaceTint: _kDarkPrimary,
);

const TextStyle _kDisplayLarge = TextStyle(
  fontSize: 57,
  fontWeight: FontWeight.w400,
  height: 1.12,
  letterSpacing: -0.25,
);
const TextStyle _kDisplayMedium = TextStyle(
  fontSize: 45,
  fontWeight: FontWeight.w400,
  height: 1.15,
);
const TextStyle _kDisplaySmall = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w400,
  height: 1.22,
);
const TextStyle _kHeadlineLarge = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w400,
  height: 1.25,
);
const TextStyle _kHeadlineMedium = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  height: 1.28,
);
const TextStyle _kHeadlineSmall = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  height: 1.33,
);
const TextStyle _kTitleLarge = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w400,
  height: 1.27,
);
const TextStyle _kTitleMedium = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  height: 1.5,
  letterSpacing: .15,
);
const TextStyle _kTitleSmall = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.43,
  letterSpacing: .1,
);
const TextStyle _kBodyLarge = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5,
  letterSpacing: .5,
);
const TextStyle _kBodyMedium = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  height: 1.42,
  letterSpacing: .25,
);
const TextStyle _kBodySmall = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  height: 1.33,
  letterSpacing: .4,
);
const TextStyle _kLabelLarge = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.42,
  letterSpacing: .1,
);
const TextStyle _kLabelMedium = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  height: 1.33,
  letterSpacing: .5,
);
const TextStyle _kLabelSmall = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w400,
  height: 1.45,
  letterSpacing: .5,
);

final TextTheme _kDarkTextTheme = TextTheme(
  displayLarge: _kDisplayLarge.copyWith(color: _kDarkTextColor),
  displayMedium: _kDisplayMedium.copyWith(color: _kDarkTextColor),
  displaySmall: _kDisplaySmall.copyWith(color: _kDarkTextColor),
  headlineLarge: _kHeadlineLarge.copyWith(color: _kDarkTextColor),
  headlineMedium: _kHeadlineMedium.copyWith(color: _kDarkTextColor),
  headlineSmall: _kHeadlineSmall.copyWith(color: _kDarkTextColor),
  titleLarge: _kTitleLarge.copyWith(color: _kDarkTextColor),
  titleMedium: _kTitleMedium.copyWith(color: _kDarkTextColor),
  titleSmall: _kTitleSmall.copyWith(color: _kDarkTextColor),
  bodyLarge: _kBodyLarge.copyWith(color: _kDarkTextColor),
  bodyMedium: _kBodyMedium.copyWith(color: _kDarkTextColor),
  bodySmall: _kBodySmall.copyWith(color: _kDarkTextColor),
  labelLarge: _kLabelLarge.copyWith(color: _kDarkTextColor),
  labelMedium: _kLabelMedium.copyWith(color: _kDarkTextColor),
  labelSmall: _kLabelSmall.copyWith(color: _kDarkTextColor),
);
final TextTheme _kLightTextTheme = TextTheme(
  displayLarge: _kDisplayLarge.copyWith(color: _kLightTextColor),
  displayMedium: _kDisplayMedium.copyWith(color: _kLightTextColor),
  displaySmall: _kDisplaySmall.copyWith(color: _kLightTextColor),
  headlineLarge: _kHeadlineLarge.copyWith(color: _kLightTextColor),
  headlineMedium: _kHeadlineMedium.copyWith(color: _kLightTextColor),
  headlineSmall: _kHeadlineSmall.copyWith(color: _kLightTextColor),
  titleLarge: _kTitleLarge.copyWith(color: _kLightTextColor),
  titleMedium: _kTitleMedium.copyWith(color: _kLightTextColor),
  titleSmall: _kTitleSmall.copyWith(color: _kLightTextColor),
  bodyLarge: _kBodyLarge.copyWith(color: _kLightTextColor),
  bodyMedium: _kBodyMedium.copyWith(color: _kLightTextColor),
  bodySmall: _kBodySmall.copyWith(color: _kLightTextColor),
  labelLarge: _kLabelLarge.copyWith(color: _kLightTextColor),
  labelMedium: _kLabelMedium.copyWith(color: _kLightTextColor),
  labelSmall: _kLabelSmall.copyWith(color: _kLightTextColor),
);

final InputDecorationTheme _kDarkInputDecoration = InputDecorationTheme(
  hintStyle: _kLabelLarge.copyWith(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF8C9198),
  ),
  border: const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF42474E),
    ),
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: _kDarkPrimary),
  ),
  iconColor: _kDarkPrimary,
  suffixIconColor: _kDarkPrimary,
);
final InputDecorationTheme _kLightInputDecoration = InputDecorationTheme(
  hintStyle: _kLabelLarge.copyWith(
    fontWeight: FontWeight.w400,
    color: const Color(0xFF72787E),
  ),
  border: const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFC2C7CE),
    ),
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: _kLightPrimary),
  ),
  iconColor: _kLightPrimary,
  suffixIconColor: _kLightPrimary,
);

final ScrollbarThemeData _kLightScrollbar = ScrollbarThemeData(
  interactive: true,
  radius: const Radius.circular(10),
  thumbColor: MaterialStateProperty.resolveWith((states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.dragged,
    };
    if (states.any((state) => interactiveStates.contains(state))) {
      return _kLightPrimary;
    }
    return const Color(0xFF72787E);
  }),
  thickness: MaterialStateProperty.all(5),
  minThumbLength: 50,
);
final ScrollbarThemeData _kDarkScrollbar = ScrollbarThemeData(
  interactive: true,
  radius: const Radius.circular(10),
  thumbColor: MaterialStateProperty.resolveWith((states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.dragged,
    };
    if (states.any((state) => interactiveStates.contains(state))) {
      return _kDarkPrimary;
    }
    return const Color(0xFF8C9198);
  }),
  thickness: MaterialStateProperty.all(5),
  minThumbLength: 50,
);

const DividerThemeData _kLightDividerTheme = DividerThemeData(
  color: Color(0xFFC2C7CE),
  thickness: 0,
  space: 1,
);
const DividerThemeData _kDarkDividerTheme = DividerThemeData(
  color: Color(0xFF42474E),
  thickness: 0,
  space: 1,
);

final AppBarTheme _kLightAppBar = AppBarTheme(
  backgroundColor: _kLightColorScheme.background,
  titleTextStyle: _kHeadlineSmall.copyWith(
    fontWeight: FontWeight.w500,
    fontFamily: kFConstantia,
    color: _kLightTextColor,
  ),
  systemOverlayStyle: const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: _kLightBg,
    systemNavigationBarIconBrightness: Brightness.dark,
  ),
  iconTheme: const IconThemeData(
    size: 24,
    color: _kLightPrimary,
  ),
);
final AppBarTheme _kDarkAppBar = AppBarTheme(
  backgroundColor: _kDarkColorScheme.background,
  titleTextStyle: _kHeadlineSmall.copyWith(
    fontFamily: kFConstantia,
    color: _kDarkTextColor,
    fontWeight: FontWeight.w500,
  ),
  systemOverlayStyle: const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: _kDarkBg,
    systemNavigationBarIconBrightness: Brightness.light,
  ),
  iconTheme: const IconThemeData(
    size: 24,
    color: _kDarkPrimary,
  ),
);

final ThemeData kTDarkTheme = ThemeData(
  colorScheme: _kDarkColorScheme,
  useMaterial3: true,
  fontFamily: kFOpenSans,
  textTheme: _kDarkTextTheme,
  inputDecorationTheme: _kDarkInputDecoration,
  scrollbarTheme: _kDarkScrollbar,
  dividerTheme: _kDarkDividerTheme,
  appBarTheme: _kDarkAppBar,
  extensions: [
    CustomColors(
      finch: const Color(0xFFCFE1C5),
      onFinch: const Color(0xFF253421),
      deepTeal: const Color(0xFF82D3DE),
      onDeepTeal: const Color(0xFF00363C),
      cetaceanBlue: const Color(0xFFBAC4F7),
      onCetaceanBlue: const Color(0xFF232E57),
      plumpPurple: const Color(0xFFD1BCFF),
      onPlumpPurple: const Color(0xFF3C088B),
      russet: const Color(0xFFFFB597),
      onRusset: const Color(0xFF552007),
      bronze: const Color(0xFFF3BE60),
      onBronze: const Color(0xFF422C00),
    ),
  ],
);
final ThemeData kTLightTheme = ThemeData(
  colorScheme: _kLightColorScheme,
  useMaterial3: true,
  fontFamily: kFOpenSans,
  textTheme: _kLightTextTheme,
  inputDecorationTheme: _kLightInputDecoration,
  scrollbarTheme: _kLightScrollbar,
  dividerTheme: _kLightDividerTheme,
  appBarTheme: _kLightAppBar,
  extensions: [
    CustomColors(
      finch: const Color(0xFF53634C),
      onFinch: const Color(0xFFFFFFFF),
      deepTeal: const Color(0xFF00565F),
      onDeepTeal: const Color(0xFFFFFFFF),
      cetaceanBlue: const Color(0xFF08143D),
      onCetaceanBlue: const Color(0xFFFFFFFF),
      plumpPurple: const Color(0xFF6B47BB),
      onPlumpPurple: const Color(0xFFFFFFFF),
      russet: const Color(0xFFA23F09),
      onRusset: const Color(0xFFFFFFFF),
      bronze: const Color(0xFF7D5700),
      onBronze: const Color(0xFFFFFFFF),
    ),
  ],
);
