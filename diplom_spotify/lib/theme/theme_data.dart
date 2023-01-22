import 'package:flutter/material.dart';

/// deepBlack
const _black = Color(0xff181818);

/// blackMatte
const _blackMatte = Color(0xff343434);

/// brightWhite
const _white = Color(0xffFFFFFF);

/// firmCol
const _purple = Color(0xff8D6CEA);

/// greyMiddle
const _grey = Color(0xff999999);

/// greyDeep
const _greyDeep = Color(0xff525252);

ThemeData _darkThemeData = ThemeData.from(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: _black,
    onPrimary: _white,
    secondary: _purple,
    onSecondary: _white,
    error: Colors.red,
    onError: Colors.redAccent,
    background: _blackMatte,
    onBackground: _grey,
    surface: _black,
    onSurface: _black,
  ),
  textTheme: const TextTheme(
    /// h_1
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 0,
      letterSpacing: 0.31,
      color: _white,
    ),

    /// 12_px_light
    bodyText2: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      height: 1.26,
      color: _grey,
    ),

    /// 10_px
    overline: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: -0.4,
      color: _grey,
    ),

    /// 12_px_reg
    bodyText1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: _white,
    ),

    /// h_2_17_px
    headline2: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 0.99,
      color: _white,
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

ThemeData themeData = _darkThemeData.copyWith(
  brightness: Brightness.dark,
  primaryColor: _grey,
  backgroundColor: _black,
  appBarTheme: const AppBarTheme(
    toolbarHeight: 83,
    iconTheme: IconThemeData(
      color: _purple,
    ),
    actionsIconTheme: IconThemeData(
      color: _purple,
    ),
    centerTitle: false,
    color: _black,
    titleTextStyle: TextStyle(
      color: _white,
      fontSize: 18,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _black,
    selectedItemColor: _purple,
    unselectedItemColor: _white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _purple,
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
      side: const BorderSide(color: _purple),
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
      activeTrackColor: _purple,
      inactiveTrackColor: _grey,
      thumbColor: _purple),
  dialogBackgroundColor: _greyDeep,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: _purple),
  iconTheme: const IconThemeData(
    size: 27.5,
    color: _purple,
  ),
);
