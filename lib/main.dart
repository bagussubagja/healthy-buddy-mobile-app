import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healthy_buddy_mobile_app/providers/providers_list.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  ErrorWidget.builder = ((details) {
    bool isDebug = false;
    assert(() {
      isDebug = true;
      return true;
    }());
    if (isDebug) {
      return ErrorWidget(details.exception);
    }
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error Ditemukan Pada Aplikasi : ${details.exception}',
        style: regularStyle,
      ),
    );
  });
  runApp(const HealthyBuddy());
}

class HealthyBuddy extends StatelessWidget {
  const HealthyBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderList.providers,
      child: const HealthyBuddyApp(),
    );
  }
}

class HealthyBuddyApp extends StatelessWidget {
  const HealthyBuddyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          supportedLocales: const [
            Locale('id', 'ID'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocaleLanguage in supportedLocales) {
              if (supportedLocaleLanguage.languageCode ==
                      locale?.languageCode &&
                  supportedLocaleLanguage.countryCode == locale?.countryCode) {
                return supportedLocaleLanguage;
              }
            }
            return supportedLocales.first;
          },
          locale: const Locale('id'),
          title: 'Healthy Buddy Mobile App',
          theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Poppins"),
          initialRoute: AppRoutes.statePageUI,
          routes: AppRoutes.routes,
          onGenerateRoute: AppRoutes.handlingGenerateRoute,
        );
      },
    );
  }
}
