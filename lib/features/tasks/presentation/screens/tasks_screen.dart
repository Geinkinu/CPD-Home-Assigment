import 'package:flutter/material.dart';
import 'package:home_assigment/features/auth/data/auth_service.dart';
import 'package:home_assigment/services/analytics_service.dart';
import 'package:home_assigment/features/auth/presentation/screens/auth_gate.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await AuthService.instance.logout();
    await AnalyticsService.instance.logEvent('logout');

    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthGate()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),

            // TODO: Implement task creation + persistence (Firestore)
            // TODO: Implement camera attachment for tasks
            // TODO: Implement local notification reminders (due tasks)
            // TODO: Implement analytics events for task flows (create, attach_photo, reminder_set)

            Text(
              'TODO:\n'
              '- Task creation + persistence (Firestore)\n'
              '- Camera attachment for tasks\n'
              '- Local notification reminders\n'
              '- Analytics events for task flows',
            ),
          ],
        ),
      ),
    );
  }
}
