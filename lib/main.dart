import 'package:flutter/material.dart';
import 'package:home_assigment/services/firebase_service.dart';
import 'package:home_assigment/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(const MyApp());
}
