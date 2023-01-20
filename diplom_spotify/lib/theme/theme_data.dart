import 'package:flutter/material.dart';

ThemeData _themeData = ThemeData.from(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: _deepBlack,
    onPrimary: _brightWhite,
    secondary: _firmCol,
    onSecondary: _brightWhite,
    error: Colors.red,
    onError: Colors.redAccent,
    background: _blackMatte,
    onBackground: _greyMiddle,
    surface: _deepBlack,
    onSurface: _deepBlack,
  ),
  textTheme: const TextTheme(
    /// h_1
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 0,
      letterSpacing: 0.31,
      color: _brightWhite,
    ),

    /// 12_px_light
    bodyText2: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      height: 1.26,
      color: _greyMiddle,
    ),

    /// 10_px
    overline: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: -0.4,
      color: _greyMiddle,
    ),

    /// 12_px_reg
    bodyText1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: _brightWhite,
    ),

    /// h_2_17_px
    headline2: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 0.99,
      color: _brightWhite,
    ),

    /// 15_px
    subtitle2: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.12,
    ),

    /// 17_px_demi
    subtitle1: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.20,
    ),
  ),
);

ThemeData darkThemeData = _themeData.copyWith(
  brightness: Brightness.dark,
  primaryColor: _greyMiddle,
  backgroundColor: _deepBlack,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: _firmCol,
    ),
    actionsIconTheme: IconThemeData(
      color: _firmCol,
    ),
    centerTitle: false,
    color: _deepBlack,
    titleTextStyle: TextStyle(
      color: _brightWhite,
      fontSize: 18,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _deepBlack,
    selectedItemColor: _firmCol,
    unselectedItemColor: _brightWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _firmCol,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(25),
          right: Radius.circular(25),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: _firmCol),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(25),
          right: Radius.circular(25),
        ),
      ),
    ),
  ),
  sliderTheme: const SliderThemeData(
      trackHeight: 2,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
      activeTrackColor: _firmCol,
      inactiveTrackColor: _greyMiddle,
      thumbColor: _firmCol),
  dialogBackgroundColor: _greyDeep,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: _firmCol),
  iconTheme: const IconThemeData(
    size: 27.5,
    color: _firmCol,
  ),
);

const _deepBlack = Color(0xff181818);
const _blackMatte = Color(0xff343434);
const _brightWhite = Color(0xffFFFFFF);
const _firmCol = Color(0xff8D6CEA);
const _greyMiddle = Color(0xff999999);
const _greyDeep = Color(0xff525252);
