import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hotel_booking_ui/common/common.dart';
import 'package:flutter_hotel_booking_ui/language/appLocalizations.dart';
import 'package:flutter_hotel_booking_ui/modules/splash/introductionScreen.dart';
import 'package:flutter_hotel_booking_ui/modules/splash/splashScreen.dart';
import 'package:flutter_hotel_booking_ui/providers/theme_provider.dart';
import 'package:flutter_hotel_booking_ui/routes/routes.dart';
import 'package:flutter_hotel_booking_ui/utils/enum.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

BuildContext? applicationcontext;

class MotelApp extends StatefulWidget {
  @override
  _MotelAppState createState() => _MotelAppState();
}

class _MotelAppState extends State<MotelApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (__, provider, child) {
        applicationcontext = context;
        final ThemeData _theme = provider.themeData;
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en'), // English
            const Locale('fr'), // French
            const Locale('ja'), // Japanese
            const Locale('ar'), // Arabic
          ],
          navigatorKey: navigatorKey,
          title: 'Motel',
          debugShowCheckedModeBanner: false,
          theme: _theme,
          routes: _buildRoutes(),
          builder: (BuildContext context, Widget? child) {
            _setFirstTimeSomeData(context, _theme);
            return Directionality(
              textDirection: context.read<ThemeProvider>().languageType ==
                      LanguageType.ar
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Builder(
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).size.width > 360
                          ? 1.0
                          : (MediaQuery.of(context).size.width >= 340 ? 0.9 : 0.8),
                    ),
                    child: child ?? SizedBox(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    applicationcontext = context;
    _setStatusBarNavigationBarTheme(theme);
    // We call some theme basic data set in the app like color, font, theme mode, language
    context.read<ThemeProvider>().checkAndSetThemeMode(
        MediaQuery.of(context).platformBrightness);
    context.read<ThemeProvider>().checkAndSetLanguage();
    context.read<ThemeProvider>().checkAndSetFonType();
    context.read<ThemeProvider>().checkAndSetColorType();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.Splash: (BuildContext context) =>
          SplashScreen(),
      RoutesName.IntroductionScreen: (BuildContext context) =>
          IntroductionScreen(),
    };
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final Brightness brightness = !kIsWeb && Platform.isAndroid
        ? (themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light)
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      systemNavigationBarColor: themeData.scaffoldBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }
}
