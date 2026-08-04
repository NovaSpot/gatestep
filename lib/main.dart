import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/start_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/set_distance_screen.dart';
import 'screens/tracking_screen.dart';
import 'screens/run_complete_screen.dart';
import 'screens/rank_up_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const GateStepApp());
}

class GateStepApp extends StatelessWidget {
  const GateStepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GateStep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/start': (context) => const StartScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/main': (context) => const MainNavigationScreen(),
        '/setDistance': (context) => const SetDistanceScreen(),
        '/tracking': (context) => const TrackingScreen(),
        '/runComplete': (context) => const RunCompleteScreen(),
        '/rankUp': (context) => const RankUpScreen(),
      },
    );
  }
}
