import 'package:flutter/material.dart';

// Screens
import '../../features/auth/screens/login_screen.dart';
import '../../features/users/screens/customer_screen.dart';
import '../../features/inspection/screens/cekpot_screen.dart';
import '../../features/inspection/screens/backlog_screen.dart';

class AppRoutes {
  // Route names
  static const String login = '/login';
  static const String customer = '/customer';
  static const String cekpot = '/cekpot';
  static const String backlog = '/backlog';

  // Route generator
  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    customer: (context) => const CustomerScreen(),
    cekpot: (context) => const CekpotScreen(),
    backlog: (context) => const BacklogScreen(),
  };

  // Route dengan arguments
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case customer:
        return MaterialPageRoute(builder: (_) => const CustomerScreen());
      case cekpot:
        return MaterialPageRoute(builder: (_) => const CekpotScreen());
      case backlog:
        return MaterialPageRoute(builder: (_) => const BacklogScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
