import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_assigment/features/tasks/data/task_model.dart';
import 'package:home_assigment/features/tasks/data/task_repository.dart';
import 'package:home_assigment/services/analytics_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _title = TextEditingController();
  final _picker = ImagePicker();

  String? _imagePath;
  bool _saving = false;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (photo == null) return;

    setState(() => _imagePath = photo.path);

    await AnalyticsService.instance.logEvent('task_photo_captured');
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) return;

    setState(() => _saving = true);

    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      imagePath: _imagePath,
    );

    TaskRepository.instance.add(task);
    await AnalyticsService.instance.logEvent('task_created', params: {
      'has_photo': _imagePath != null,
    });

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preview = _imagePath == null
        ? const Text('No photo attached.')
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(_imagePath!),
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Task title',
              ),
            ),
            const SizedBox(height: 16),
            preview,
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saving ? null : _save,
                    child: Text(_saving ? 'Saving...' : 'Save'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // TODO: Later persist tasks to Firestore and store image in Firebase Storage.
            const Text(
              'TODO: Persist tasks to Firestore + store images in Firebase Storage',
            ),
          ],
        ),
      ),
    );
  }
}
