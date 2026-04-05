import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/routes.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/request_provider.dart';
import 'core/providers/driver_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: Firebase.initializeApp() will fail without google-services.json/GoogleService-Info.plist
  // For this environment, I'll wrap it in a try-catch to allow the UI work to continue.
  try {
    // await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization skipped or failed: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => DriverProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satahti',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
