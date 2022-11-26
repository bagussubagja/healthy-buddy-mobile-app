import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healthy_buddy_mobile_app/providers/providers_list.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
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
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Poppins"),
          initialRoute: AppRoutes.statePageUI,
          routes: AppRoutes.routes,
          onGenerateRoute: AppRoutes.handlingGenerateRoute,
        );
      },
    );
  }
}
