import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/router.dart';

void main() {
  // Ensure Flutter engine bindings are initialized prior to loading database files
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: CartRentParkingApp(),
    ),
  );
}

class CartRentParkingApp extends StatelessWidget {
  const CartRentParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CartRent Parking',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      routerConfig: goRouter,
    );
  }
}
