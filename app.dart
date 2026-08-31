import 'package:flutter/material.dart';

import 'auth/auth_gate.dart';

// ============================================================
// APLICATIVO
// ============================================================

class AvenidaApp extends StatelessWidget {
  const AvenidaApp({super.key});

  static const Color azulAvenida = Color(0xFF0757B8);
  static const Color azulEscuro = Color(0xFF063B7A);
  static const Color azulClaro = Color(0xFFEAF3FF);
  static const Color fundo = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: azulAvenida,
      brightness: Brightness.light,
    ).copyWith(
      primary: azulAvenida,
      onPrimary: Colors.white,
      primaryContainer: azulClaro,
      onPrimaryContainer: azulEscuro,
      surface: Colors.white,
      onSurface: const Color(0xFF172033),
      outline: const Color(0xFFDCE2EA),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avenida',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: fundo,

        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF172033),
          elevation: 0,
          centerTitle: false,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Color(0xFFE7EBF1),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDCE2EA),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDCE2EA),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: azulAvenida,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE53935),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE53935),
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF667085),
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: azulAvenida,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: azulAvenida,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: azulAvenida,
            minimumSize: const Size.fromHeight(50),
            side: const BorderSide(
              color: Color(0xFFD5DCE6),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          side: const BorderSide(
            color: Color(0xFFB8C1CE),
            width: 1.5,
          ),
          fillColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return azulAvenida;
              }
              return Colors.white;
            },
          ),
        ),

        navigationBarTheme: NavigationBarThemeData(
          height: 72,
          backgroundColor: Colors.white,
          elevation: 0,
          indicatorColor: azulClaro,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF172033),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
