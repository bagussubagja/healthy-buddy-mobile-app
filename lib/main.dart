import 'package:flutter/material.dart';
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
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Poppins"),
          initialRoute: AppRoutes.bodyScreen,
          routes: AppRoutes.routes,
          onGenerateRoute:AppRoutes.handlingGenerateRoute,
        );
      },
    );
  }
}
