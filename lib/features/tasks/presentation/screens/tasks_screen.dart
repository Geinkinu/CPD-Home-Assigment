import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home_assigment/features/auth/data/auth_service.dart';
import 'package:home_assigment/features/auth/presentation/screens/auth_gate.dart';
import 'package:home_assigment/features/tasks/data/task_repository.dart';
import 'package:home_assigment/features/tasks/presentation/screens/add_task_screen.dart';
import 'package:home_assigment/services/analytics_service.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  Future<void> _logout() async {
    await AuthService.instance.logout();
    await AnalyticsService.instance.logLogout();

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthGate()),
      (_) => false,
    );
  }

  Future<void> _openAddTask() async {
    final result = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => const AddTaskScreen()));

    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = TaskRepository.instance.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTask,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: tasks.isEmpty
            ? const Text(
                'Create your first task using the + button.\n'
                'Tasks will later be persisted to Firestore.',
              )
            : ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final t = tasks[i];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    leading: t.imagePath == null
                        ? const Icon(Icons.task_alt)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(t.imagePath!),
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              cacheWidth: 96,
                              cacheHeight: 96,
                            ),
                          ),
                    title: Text(t.title),
                    subtitle: Text(
                      t.imagePath == null
                          ? 'No photo attached'
                          : 'Photo attached',
                    ),
                  );
                },
              ),
      ),
    );
  }
}
