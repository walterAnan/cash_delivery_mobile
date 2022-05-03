import 'package:flutter/material.dart';

const  MaterialColor myColor = const MaterialColor(
    0xFFF54D6E,
    const <int, Color>{
      50: const Color(0xFFF54D6E),
      100: const Color(0xFFF54D6E),
      200: const Color(0xFFF54D6E),
      300: const Color(0xFFF54D6E),
      400: const Color(0xFFF54D6E),
      500: const Color(0xFFF54D6E),
      600: const Color(0xFFF54D6E),
      700: const Color(0xFFF54D6E),
      800: const Color(0xFFF54D6E),
      900: const Color(0xFFF54D6E),
    }
);


class Styles {

  static const Color primaryColor = const Color(0xFFDC2529);
  static const Color searchBarColor = Color(0xFFededed);
  static const Color blackTextColor = Color(0xFF000000);
  static const Color whiteTextColor = Color(0xFFffffff);
  static const Color containerBkgColor = Color(0xFF555869);

  static const Color white = const Color(0xFFFFFFFF);
  static const Color lightWhite = Color(0xFFF7F7F7);
  static const Color dark = Color(0xFF2A2E43);
  static const Color black = Color(0xFF000000);
  static const Color grey = const Color(0xffA8A8A8);
  static const Color green = const Color(0xff32CD32);
  static const Color divider = const Color(0xFFEFEFF1);

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: myColor,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      scaffoldBackgroundColor:isDarkTheme ?Color(0xFF2A2E43): Color(0xFFFFFFFF),
      backgroundColor: isDarkTheme ? containerBkgColor : searchBarColor,
      canvasColor: isDarkTheme ? Color(0xFF2A2E43): Color(0xFFFFFFFF),
      bottomAppBarColor: isDarkTheme? Color(0xFF2A2E43): Color(0xFFFFFFFF),
      cardColor: isDarkTheme? Color(0xFF2A2E43): Color(0xFFFFFFFF),
      appBarTheme: AppBarTheme(
        color: isDarkTheme ? dark : lightWhite,
        titleTextStyle: TextStyle(
          color: isDarkTheme ? white : black
        )
      ),

      bottomAppBarTheme: BottomAppBarTheme(
        color: isDarkTheme ? Color(0xFF2A2E43): Color(0xFFFFFFFF),
        elevation: 0
      ),

      tabBarTheme: TabBarTheme(
        unselectedLabelColor: isDarkTheme ? whiteTextColor : blackTextColor,
      ),
      iconTheme: IconThemeData(
          color: isDarkTheme ? white : black
      ),

      inputDecorationTheme: InputDecorationTheme(
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(
                  color: Color(0x80C2C2C2)
              )
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x80C2C2C2)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x80C2C2C2)),
          ),
          errorBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x80C2C2C2)),
          ),
          focusedErrorBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x80C2C2C2)),
          ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x80C2C2C2)),
        ) ,
        labelStyle: TextStyle(
          color: Color(0xFF787878),
        ),
        fillColor: isDarkTheme ? dark : white

    ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Color(0xFFF54D6E	)
      ),

      textTheme: new TextTheme(
        headline1: TextStyle(
          color: isDarkTheme ?Color(0xFFFFFFFF):Color(0xFF000000),
        ),
        headline2: TextStyle(
          color:isDarkTheme ? Color(0xFF000000):Color(0xFFFFFFFF),
        ),
        headline3: TextStyle(
          color: Color(0xFF787878),
        ),
        headline4: TextStyle(
          color: Color(0xFFC2C2C2),
        ),
        headline5: TextStyle(
          color: Color(0x80C2C2C2),
        ),
        headline6: TextStyle(
          color: Color(0xFFEDEDED),
        ),
        bodyText1: TextStyle(
          color: isDarkTheme? Color(0xFFFFFFFF):Color(0xFFEDEDED),
        ),
      ),
      accentTextTheme: new TextTheme(
        headline1: TextStyle(
          color:  Color(0xFFF54D6E),
        ),
        headline2: TextStyle(
          color:  Color(0xFF4CAF50),
        ),
        headline3: TextStyle(
          color:  Color(0xFFFFA500),
        ),
        headline4: TextStyle(
          color: Color(0xFFF57C00)
        ),
        headline5: TextStyle(
            color: Color(0xFF00ACC1)
        ),
        headline6: TextStyle(
          color: Color(0xFF0033cc)
        ),
        bodyText1: TextStyle(
          color: Color(0xFF000000),
        ),
        bodyText2: TextStyle(
          color:Color(0xFFFFFFFF),
        ),
      ),
      primaryTextTheme: new TextTheme(
        headline1: TextStyle(
          color:  Color(0xFFC2C2C2),
        ),
        headline2: TextStyle(
          color:  Color(0x80C2C2C2),
        ),
        headline3: TextStyle(
          color:  Color(0x60C2C2C2),
        ),
        headline4: TextStyle(
          color:  Color(0x40C2C2C2),
        ),
        headline5: TextStyle(
          color:  Color(0xFFEDEDED),
        ),
      ),
      hintColor: Color(0xFFC2C2C2),
      fontFamily: "medium",
      indicatorColor: Colors.white,
      toggleableActiveColor: isDarkTheme? Color(0xFFF54D6E):Color(0xFF000000),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      focusColor: Colors.transparent,
      errorColor: const Color(0xFFB00020),
      //My

      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
            color: isDarkTheme ? Color(0xFF2A2E43) : white
        )
      ),

      cardTheme: CardTheme(
        color: isDarkTheme ? Color(0xFF2A2E43) : white,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDarkTheme ? containerBkgColor : black
      ),

      dialogBackgroundColor: isDarkTheme ? Color(0xFF2A2E43) : white,
    );
  }
}