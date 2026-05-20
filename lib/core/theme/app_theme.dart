import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark mode color palette based on premium HSL/modern design tokens
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color surface = Color(0xFF1E293B);    // Slate 800
  static const Color cardBg = Color(0xFF334155);     // Slate 700 (with opacity)
  
  // Neon Accents
  static const Color accent = Color(0xFF8B5CF6);     // Neon Violet
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color primary = Color(0xFF06B6D4);    // Vibrant Cyan
  
  // Status Colors
  static const Color available = Color(0xFF10B981);  // Emerald Green
  static const Color occupied = Color(0xFFEF4444);   // Crimson Red
  static const Color reserved = Color(0xFFF59E0B);   // Amber Orange
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);  // Slate 50
  static const Color textSecondary = Color(0xFF94A3B8);// Slate 400
  static const Color textMuted = Color(0xFF64748B);    // Slate 500

  // Modern linear gradient for cards/buttons
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkGlassGradient = LinearGradient(
    colors: [
      Color(0x1F1E293B), // Transparent slate
      Color(0x3D334155),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surface,
        background: background,
        error: occupied,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary),
          titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
          bodyLarge: const TextStyle(fontSize: 16, color: textPrimary),
          bodyMedium: const TextStyle(fontSize: 14, color: textSecondary),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF334155), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF334155), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
