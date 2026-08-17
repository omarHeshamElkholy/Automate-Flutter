import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_scaffold.dart';
import 'screens/add_vehicle_screen.dart';
import 'screens/vehicle_details_screen.dart';
import 'screens/add_record_screen.dart';
import 'screens/reminder_details_screen.dart';

import 'package:provider/provider.dart';
import 'providers/car_provider.dart';
import 'providers/specialist_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => SpecialistProvider()),
      ],
      child: const MyCarEgyptApp(),
    ),
  );
}

class MyCarEgyptApp extends StatelessWidget {
  const MyCarEgyptApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Deep Automotive Blue
    const Color primaryBlue = Color(0xFF0F172A);
    // Refined Lavender
    const Color accentLavender = Color(0xFFE8AAE1);
    
    return MaterialApp(
      title: 'AutoMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FF),
        primaryColor: primaryBlue,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: accentLavender,
          surface: Colors.white,
          onSurface: primaryBlue,
          onPrimary: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
          bodyColor: primaryBlue,
          displayColor: primaryBlue,
        ),
        
        // Cohesive button styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBlue,
            side: const BorderSide(color: primaryBlue, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        
        // Styled inputs
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          prefixIconColor: const Color(0xFF515F74),
          suffixIconColor: const Color(0xFF515F74),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFC6C6CD), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFC6C6CD), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: accentLavender, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: const TextStyle(color: Color(0xFF515F74)),
        ),
        
        // Rounded Cards
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE5EEFF), width: 1), // surface-container
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScaffold(),
        '/vehicle-details': (context) => const VehicleDetailsScreen(),
        '/add-vehicle': (context) => const AddVehicleScreen(),
        '/add-record': (context) => const AddRecordScreen(),
        '/reminder-details': (context) => const ReminderDetailsScreen(),
      },
    );
  }
}
