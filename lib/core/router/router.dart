import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/parking_map/presentation/parking_map_screen.dart';
import '../../features/parking_map/presentation/map_editor_screen.dart';
import '../../features/rentals/presentation/rental_list_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/auth/presentation/login_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const ParkingMapScreen(),
    ),
    GoRoute(
      path: '/editor',
      builder: (context, state) => const MapEditorScreen(),
    ),
    GoRoute(
      path: '/rentals',
      builder: (context, state) => const RentalListScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
