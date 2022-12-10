import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moontime/utilities/colours.dart';

class Themes {
  Themes._(); //this is to prevent anyone from instantiating this object
  static const Color primary = Colours.moonBlueLight;

  static String isidora = "Isidora";
  static String isidoraSans = "IsidoraSans";
  static final TextTheme lightTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 36.0,
        // height: 1.5,
        color: Colours.black,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w700),
    headline2: TextStyle(
        fontSize: 32.0,
        // height: 1.5,
        color: Colours.black,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w700),
    headline4: TextStyle(
        fontSize: 24.0,
        color: Colours.black,
        fontFamily: isidora,
        fontWeight: FontWeight.w600),
    headline5: TextStyle(
        fontSize: 22.0,
        color: Colours.black,
        fontFamily: isidora,
        fontWeight: FontWeight.w600),
    headline6: TextStyle(
        fontSize: 18.0,
        color: Colours.black,
        fontFamily: isidora,
        fontWeight: FontWeight.w600),
    bodyText1: TextStyle(
        fontSize: 16.0,
        color: Colours.black,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w500),
    bodyText2: TextStyle(
        fontSize: 14.0,
        color: Colours.black,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w500),
    subtitle1: TextStyle(
        fontSize: 16.0,
        color: Colours.black,
        fontFamily: isidora,
        fontWeight: FontWeight.w600),
    subtitle2: TextStyle(
        fontSize: 14.0,
        color: Colours.darkShade500,
        fontFamily: isidora,
        fontWeight: FontWeight.w600),
    button: TextStyle(
        fontSize: 14.0,
        // height: 1.5,
        color: Colours.darkShade700,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w600),
    caption: TextStyle(
        fontSize: 12.0,
        color: Colours.darkShade700,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w500),
    overline: TextStyle(
        fontSize: 10.0,
        letterSpacing: 0,
        color: Colours.darkShade700,
        fontFamily: isidoraSans,
        fontWeight: FontWeight.w600),
  );
  static final TextTheme darkTextTheme = lightTextTheme.copyWith(
    headline1: lightTextTheme.headline1?.copyWith(color: Colours.white),
    headline2: lightTextTheme.headline2?.copyWith(color: Colours.white),
    headline4: lightTextTheme.headline4?.copyWith(color: Colours.white),
    headline5: lightTextTheme.headline5?.copyWith(color: Colours.white),
    headline6: lightTextTheme.headline6?.copyWith(color: Colours.white),
    bodyText1: lightTextTheme.bodyText1?.copyWith(color: Colours.light),
    bodyText2: lightTextTheme.bodyText2?.copyWith(color: Colours.lightShade900),
    subtitle1: lightTextTheme.subtitle1?.copyWith(color: Colours.lightShade100),
    subtitle2: lightTextTheme.subtitle2?.copyWith(color: Colours.lightShade200),
    button: lightTextTheme.button?.copyWith(color: Colours.lightShade300),
    caption: lightTextTheme.caption?.copyWith(color: Colours.lightShade400),
    overline: lightTextTheme.overline?.copyWith(color: Colours.lightShade900),
  );
  static final ThemeData lightThemeData = ThemeData.light().copyWith(
    textTheme: lightTextTheme,
    primaryTextTheme: lightTextTheme,
    scaffoldBackgroundColor: Colours.lightBg,
    /*textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary,
      selectionHandleColor: primary,
    ),*/
    backgroundColor: Colours.lightBg,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colours.lightShade400),
      thumbColor: MaterialStateProperty.all(primary),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(fontSize: 14),
        )),
    iconTheme: const IconThemeData(color: Colours.lightShade800),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleSpacing: 6,
      backgroundColor: Colours.lightBg,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(color: Colours.dark),
    ),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colours.black,
     /* primaryContainer: Colours.greenShade700,
      secondary: Colours.yellow,
      secondaryContainer: Colours.yellowShade500,
      onSecondary: Colours.yellowShade900,
      tertiary: Colours.red,
      tertiaryContainer: Colours.redShade500,
      onTertiary: Colours.redShade900,*/
      surface: Colours.lightShade100,
      onSurface: Colours.lightShade600,
      surfaceTint: Colours.lightShade300,
      background: Colours.lightBg,
      onBackground: Colours.darkShade500,
      error: Colours.redError,
      onError: Colours.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.white10),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shape: MaterialStateProperty.all(
              // ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)))
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)))))),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(
          fontSize: 14.0,
          color: Colours.darkShade400,
          fontWeight: FontWeight.w600,
          letterSpacing: 0),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: primary, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: Colours.lightShade300, width: 1)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        borderSide: BorderSide(color: Colours.lightShade100, width: 5),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: primary, width: 1)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: Colours.redError, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: Colours.redError, width: 1)),
    ),
  );

  static final ThemeData darkThemeData = ThemeData.dark().copyWith(
    textTheme: darkTextTheme,
    cupertinoOverrideTheme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
            TextStyle(color: Colours.lightShade100, fontSize: 14))),
    /*textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary,
      selectionHandleColor: primary,
    ),*/
    primaryTextTheme: darkTextTheme,
    iconTheme: const IconThemeData(color: Colours.darkShade400),
    scaffoldBackgroundColor: Colours.darkBg,
    backgroundColor: Colours.darkBg,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colours.darkShade600),
      thumbColor: MaterialStateProperty.all(primary),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleSpacing: 6,
      backgroundColor: Colours.darkBg,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Colours.light),
    ),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: primary,
      // primaryContainer: Colours.greenShade700,
      onPrimary: Colours.white,
      // secondary: Colours.yellow,
      // secondaryContainer: Colours.yellowShade500,
      // onSecondary: Colours.yellowShade900,
      surface: Colours.darkShade700,
      // unselectedWidgetColor: Colours.darkShade400,
      surfaceTint: Colours.darkShade600,
      onSurface: Colours.darkShade400,
      tertiary: Colours.moonOrangeDeep,
      tertiaryContainer: Colours.moonOrangeLight,
      onTertiary: Colours.white,
      background: Colours.darkBg,
      onBackground: Colours.lightShade900,
      error: Colours.redError,
      onError: Colours.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.white10),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shape: MaterialStateProperty.all(
              // ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)))
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)))))),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(
          fontSize: 14.0,
          color: Colours.darkShade400,
          fontWeight: FontWeight.w600,
          letterSpacing: 0),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: primary, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: Colours.darkShade600, width: 1)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        borderSide: BorderSide(color: Colours.darkShade800, width: 5),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: primary, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: Colours.redError, width: 1)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(color: Colours.redError, width: 1)),
    ),
  );

  static InputDecoration inputDecorationFilled({
    required BuildContext context,
    EdgeInsets? contentPadding,
    Widget? suffix,
    double borderRadius=32,
    Widget? suffixIcon,
    Widget? prefix,
    Widget? prefixIcon,
    FloatingLabelAlignment? floatingLabelAlignment,
    String? labelText,
    String? hintText,
    Color? fillColor,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
  }) =>
      InputDecoration(
          filled: true,
          counter: const SizedBox.shrink(),
          // alignLabelWithHint: true,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          floatingLabelAlignment:
          floatingLabelAlignment ?? FloatingLabelAlignment.center,
          labelText: labelText,
          hintText: hintText,
          suffix: suffix,
          suffixIcon: suffixIcon,
          prefix: prefix,
          prefixIcon: prefixIcon,
          fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
          labelStyle: labelStyle ??
              TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0),
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: const BorderSide(color: Colors.transparent, width: 0)),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: const BorderSide(color: Colors.transparent, width: 0)),
          border:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: const BorderSide(color: Colors.transparent, width: 0)));
}
