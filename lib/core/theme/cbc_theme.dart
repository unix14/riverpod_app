import 'package:flutter/material.dart';

class CBCTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
        color: Color(0xff000000),
      ),
      cardColor: Colors.white,
      cardTheme: const CardTheme(
        color: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      dividerColor: Colors.grey,
      tabBarTheme: const TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        dividerColor: Colors.black,
        indicatorColor: Colors.white,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
      ),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.grey),
      ),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          tertiary: Colors.black,
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          surfaceTint: Colors.black,
          secondaryContainer: Colors.grey,
          primaryContainer: Colors.grey,
          onPrimaryContainer: Colors.grey,
          inversePrimary: Colors.white
      ),
      textSelectionTheme:
      const TextSelectionThemeData(selectionColor: Color(0xff6699ff)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 22,
            height: 1.27,
            color: Color(0xff333333)),
        titleMedium: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.1,
            height: 1.5,
            color: Color(0xff333333)),
        titleSmall: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.1,
            height: 1.43,
            color: Color(0xff333333)),
        labelLarge: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.1,
            height: 1.43,
            color: Color(0xff333333)),
        labelMedium: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            letterSpacing: 0.5,
            height: 1.33,
            color: Color(0xff333333)),
        labelSmall: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 11,
            letterSpacing: 0.5,
            height: 1.45,
            color: Color(0xff333333)),
        bodyLarge: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0.5,
            height: 1.5,
            textBaseline: TextBaseline.ideographic,
            color: Color(0xff333333)),
        bodyMedium: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.43,
            letterSpacing: 0.25,
            color: Color(0xff333333)),
        bodySmall: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0.4,
            height: 1.33,
            color: Color(0xff333333)),
      ),
      useMaterial3: true,
    );
  }
}
