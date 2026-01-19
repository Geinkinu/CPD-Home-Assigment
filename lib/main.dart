import 'package:flutter/material.dart';
import 'package:home_assigment/app/app.dart';
import 'package:home_assigment/services/firebase_service.dart';
import 'package:home_assigment/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();

  await NotificationService.instance.init();
  await NotificationService.instance.requestAndroidPermissionIfNeeded();

  runApp(const MyApp());
}
