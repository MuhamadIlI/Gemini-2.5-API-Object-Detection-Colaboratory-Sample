import 'package:flutter/material.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/role_selection_screen.dart';
import 'ui/screens/user_registration_screen.dart';
import 'ui/screens/driver_registration_screen.dart';
import 'ui/screens/driver_dashboard_screen.dart';
import 'ui/screens/searching_screen.dart';
import 'ui/screens/ads_screen.dart';
import 'ui/screens/support_screen.dart';
import 'ui/screens/admin_panel_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String roleSelection = '/role';
  static const String userRegister = '/user-register';
  static const String driverRegister = '/driver-register';
  static const String driverDashboard = '/driver-dashboard';
  static const String ads = '/ads';
  static const String support = '/support';
  static const String admin = '/admin';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashScreen(),
    roleSelection: (_) => const RoleSelectionScreen(),
    userRegister: (_) => const UserRegistrationScreen(),
    driverRegister: (_) => const DriverRegistrationScreen(),
    driverDashboard: (_) => const DriverDashboardScreen(),
    ads: (_) => const AdsScreen(),
    support: (_) => const SupportScreen(),
    admin: (_) => const AdminPanelScreen(),
  };
}
