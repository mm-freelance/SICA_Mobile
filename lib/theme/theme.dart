import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //AppTheme._();
  //One instance, needs factory 
  static AppTheme? _instance;
  factory AppTheme() => _instance ??=  AppTheme._();
  AppTheme._();
  static  Color whiteBackgroundColor =  Color(0xffffffff);
  //static  Color primaryColor =  Color.fromRGBO(245, 198, 24, 1);
  static  Color darkPrimaryColor = Color(0xFFF6C977);
    static  Color primaryColor =  Color.fromRGBO(245, 198, 24, 1);
  static  Color blackColor =  Color(0xff040415);
  static  Color lightTextColor =  Color.fromRGBO(77, 77, 77, 1);
  static  Color darkTextColor =  Color.fromRGBO(0, 0, 0, 1);
  static  Color backGround =  Color.fromRGBO(243, 242, 238, 1);
  static  Color backGround2 =  Color.fromRGBO(241, 242, 246, 1);
  static  Color bodyTextColor =  Color.fromRGBO(26, 26, 26, 1);
  static  Color buttonBorder =  Color.fromRGBO(38, 130, 255, 1);
  static  Color hintTextColor =  Color.fromRGBO(127, 127, 127, 1);
  static  Color yelloDarkColor =  Color.fromRGBO(255, 187, 0, 1);
  static  Color cardColor =  Color.fromRGBO(246, 246, 246, 1);
  static  Color cardDarkColor =  Color.fromRGBO(29, 34, 38, 1);

  static final TextStyle headingText = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 26,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle title16Px = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 16,
    letterSpacing: 0,
    height: 0,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle text14Px = GoogleFonts.inter(
    color: darkTextColor,
    fontSize: 14,
    letterSpacing: 0,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle text14500Px = GoogleFonts.inter(
    color: hintTextColor,
    fontSize: 14,
    letterSpacing: 0,
    height: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle text20600Px = GoogleFonts.inter(
    color: lightTextColor,
    fontSize: 20,
    letterSpacing: 0,
    height: 0,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle lightBoldText = GoogleFonts.inter(
    color: lightTextColor,
    fontSize: 14,
    letterSpacing: 0,
    height: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle hintText = GoogleFonts.inter(
    color: hintTextColor,
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle authScreenTitle = GoogleFonts.inter(
      fontSize: 20,
      color: darkTextColor,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      height: 1.4);
  static final TextStyle lableInputText = GoogleFonts.inter(
    fontSize: 14,
    letterSpacing: 0,
    color: lightTextColor,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle smallText = GoogleFonts.inter(
    fontSize: 16,
    letterSpacing: 0,
    color: hintTextColor,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle smallTextDark = GoogleFonts.inter(
    fontSize: 16,
    letterSpacing: 0,
    color: hintTextColor,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle extraSmallText = GoogleFonts.inter(
    fontSize: 14,
    letterSpacing: 0,
    color: lightTextColor,
    fontWeight: FontWeight.w400,
  );
  static final darkTheme = ThemeData(
    useMaterial3: false,
    //fontFamily: GoogleFonts.inter().fontFamily,
    cardColor: cardDarkColor,
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: appBarDarkTheme(),

   
    iconTheme: IconThemeData(color: hintTextColor),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    // colorScheme: ThemeData().colorScheme.copyWith(
    //       secondary: Colors.blue,
    //     ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkPrimaryColor,
      selectionColor: darkPrimaryColor,
      selectionHandleColor: darkPrimaryColor,
    ),
    tabBarTheme: tabBarDarkTheme(),

    // text theme
    textTheme: TextTheme(
      headlineMedium: title16Px.copyWith(color: AppTheme.whiteBackgroundColor),
      headlineLarge: headingText.copyWith(color: AppTheme.whiteBackgroundColor),
      displayLarge: text14Px.copyWith(color: AppTheme.whiteBackgroundColor),
      bodyLarge: text14500Px.copyWith(color: AppTheme.whiteBackgroundColor),
      displayMedium: smallText.copyWith(color: AppTheme.whiteBackgroundColor),
      headlineSmall: text20600Px.copyWith(color: AppTheme.whiteBackgroundColor),
      bodyMedium: smallTextDark.copyWith(color: AppTheme.whiteBackgroundColor),
      bodySmall: extraSmallText.copyWith(color: AppTheme.whiteBackgroundColor),
      labelSmall: lableInputText.copyWith(color: AppTheme.whiteBackgroundColor),
      labelLarge: lightBoldText.copyWith(color: AppTheme.whiteBackgroundColor),
      labelMedium:
          authScreenTitle.copyWith(color: AppTheme.whiteBackgroundColor),
      displaySmall: hintText.copyWith(color: AppTheme.whiteBackgroundColor),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: darkPrimaryColor),

 //   visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    //   surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    //  scrolledUnderElevation: 0,

    actionsIconTheme: IconThemeData(color: AppTheme.darkTextColor),
    iconTheme: IconThemeData(color: AppTheme.darkTextColor),
    titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        color: AppTheme.darkTextColor,
        fontWeight: FontWeight.w600),
  );
}

AppBarTheme appBarDarkTheme() {
  return AppBarTheme(
    //   surfaceTintColor: Colors.transparent,
    backgroundColor: Color(0xFF121212),
    shadowColor: Color(0xFFECE5B5),
    actionsIconTheme: IconThemeData(color: AppTheme.primaryColor),
    iconTheme: IconThemeData(color: AppTheme.primaryColor),
    titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        color: AppTheme.whiteBackgroundColor,
        fontWeight: FontWeight.w600),
  );
}

TabBarTheme tabBarTheme() {
  return TabBarTheme(
    labelColor: AppTheme.yelloDarkColor,
    indicatorColor: AppTheme.yelloDarkColor,
    unselectedLabelColor: AppTheme.darkTextColor,
    unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        color: AppTheme.darkTextColor,
        fontWeight: FontWeight.w600),
    labelStyle: GoogleFonts.inter(
        fontSize: 16,
        color: AppTheme.darkTextColor,
        fontWeight: FontWeight.w600), // color for text
  );
}

TabBarTheme tabBarDarkTheme() {
  return TabBarTheme(
    labelColor: AppTheme.darkPrimaryColor,
    indicatorColor: AppTheme.darkPrimaryColor,
    unselectedLabelColor: AppTheme.whiteBackgroundColor,
    unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        color: AppTheme.whiteBackgroundColor,
        fontWeight: FontWeight.w600),
    labelStyle: GoogleFonts.inter(
        fontSize: 16,
        color: AppTheme.whiteBackgroundColor,
        fontWeight: FontWeight.w600), // color for text
  );
}
