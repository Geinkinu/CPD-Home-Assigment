import 'package:flutter/material.dart';
import 'package:home_assigment/core/theme/app_theme.dart';
import 'package:home_assigment/features/auth/presentation/screens/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPD Home',
      theme: AppTheme.light(),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
