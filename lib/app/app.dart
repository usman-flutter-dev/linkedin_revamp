import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../views/home/home_screen.dart';
import '../views/notifications/notifications_screen.dart';

/// Root widget of the application.
/// Configures [MaterialApp] with theme and initial route.
class LinkedInApp extends StatelessWidget {
  const LinkedInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkedIn Redesign',
      debugShowCheckedModeBanner: false,

      // Apply global theme from AppTheme
      theme: AppTheme.lightTheme,

      // Named routes for navigating between screens
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/notifications': (_) => const NotificationsScreen(),
      },
    );
  }
}
