import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService._();
  static final instance = AnalyticsService._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logLogin({required String method}) async {
    await _analytics.logLogin(loginMethod: method);
  }

  Future<void> logSignUp({required String method}) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  Future<void> logLogout() async {
    await _analytics.logEvent(name: 'logout');
  }

  Future<void> logTaskCreated({required bool hasPhoto}) async {
    await _analytics.logEvent(
      name: 'task_created',
      parameters: {'has_photo': hasPhoto ? 1 : 0},
    );
  }

  Future<void> logTaskPhotoCaptured() async {
    await _analytics.logEvent(name: 'task_photo_captured');
  }
}
