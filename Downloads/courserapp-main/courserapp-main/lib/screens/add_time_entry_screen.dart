import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';
import '../services/time_entry_provider.dart';
import 'add_project_screen.dart';
import 'add_task_screen.dart';

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({super.key});

  @override
  State<AddTimeEntryScreen> createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  String? _selectedProjectName;
  String? _selectedTaskName;
  DateTime _selectedDate = DateTime.now();
  int _hours = 0;
  int _minutes = 0;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // tasks are read directly from the provider when needed

  Future<void> _saveTimeEntry() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedProjectName == null || _selectedProjectName!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a project')),
        );
        return;
      }

      if (_selectedTaskName == null || _selectedTaskName!.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a task')));
        return;
      }

      final totalTime = Duration(hours: _hours, minutes: _minutes);

      final entry = TimeEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        projectName: _selectedProjectName!,
        taskName: _selectedTaskName!,
        notes: _notesController.text,
        date: _selectedDate,
        totalTime: totalTime,
      );

      await context.read<TimeEntryProvider>().addEntry(entry);
      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimeEntryProvider>();
    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Ensure dropdowns always have at least three distinct options so they display
    final projectsList = <Project>[];
    projectsList.addAll(provider.projects);
    // Append placeholder projects until we have 3
    var placeholderProjectIndex = 1;
    while (projectsList.length < 3) {
      final name = 'Sample Project $placeholderProjectIndex';
      // avoid name collisions
      if (!projectsList.any((p) => p.name == name)) {
        projectsList.add(
          Project(
            id: 'sample-project-$placeholderProjectIndex-${DateTime.now().millisecondsSinceEpoch}',
            name: name,
            description: '',
            createdAt: DateTime.now(),
          ),
        );
      }
      placeholderProjectIndex++;
      if (placeholderProjectIndex > 10) break; // safety
    }

    final tasksList = <Task>[];
    tasksList.addAll(provider.tasks);
    // Ensure tasks have at least 3 items; attach placeholders to first project if needed
    var placeholderTaskIndex = 1;
    while (tasksList.length < 3) {
      final name = 'Sample Task $placeholderTaskIndex';
      if (!tasksList.any((t) => t.name == name)) {
        tasksList.add(
          Task(
            id: 'sample-task-$placeholderTaskIndex-${DateTime.now().millisecondsSinceEpoch}',
            name: name,
            description: '',
            projectId: projectsList.first.id,
            createdAt: DateTime.now(),
          ),
        );
      }
      placeholderTaskIndex++;
      if (placeholderTaskIndex > 10) break; // safety
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Time Entry'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Time
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Time',
                  hintText: 'Enter time in hours and minutes',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total time';
                  }
                  return null;
                },
                onChanged: (value) {
                  final parts = value.split(':');
                  if (parts.length == 2) {
                    _hours = int.tryParse(parts[0]) ?? 0;
                    _minutes = int.tryParse(parts[1]) ?? 0;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Project Dropdown with inline add button
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                      ),
                      initialValue:
                          _selectedProjectName ??
                          (projectsList.isNotEmpty
                              ? projectsList.first.name
                              : null),
                      items: projectsList
                          .map(
                            (Project project) => DropdownMenuItem<String>(
                              value: project.name,
                              child: Text(project.name),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedProjectName = newValue;
                          _selectedTaskName =
                              null; // Reset task when project changes
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a project';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    tooltip: 'Add Project',
                    onPressed: () async {
                      final provider = context.read<TimeEntryProvider>();
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddProjectScreen(),
                        ),
                      );
                      if (result == true) {
                        // reload provider lists and select the newly added project name if any
                        await provider.loadAll();
                        if (!mounted) return;
                        if (provider.projects.isNotEmpty) {
                          setState(() {
                            _selectedProjectName = provider.projects.last.name;
                            _selectedTaskName = null;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Task Dropdown with inline add button
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Task Name'),
                      initialValue:
                          _selectedTaskName ??
                          (tasksList.isNotEmpty ? tasksList.first.name : null),
                      items: (() {
                        final filteredTasks = _selectedProjectName == null
                            ? tasksList
                            : tasksList
                                  .where(
                                    (t) =>
                                        t.projectId ==
                                        projectsList
                                            .firstWhere(
                                              (p) =>
                                                  p.name ==
                                                  _selectedProjectName,
                                              orElse: () => projectsList.first,
                                            )
                                            .id,
                                  )
                                  .toList();
                        return filteredTasks
                            .map(
                              (Task task) => DropdownMenuItem<String>(
                                value: task.name,
                                child: Text(task.name),
                              ),
                            )
                            .toList();
                      })(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTaskName = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a task';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    tooltip: 'Add Task',
                    onPressed: () async {
                      final provider = context.read<TimeEntryProvider>();
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddTaskScreen(),
                        ),
                      );
                      if (result == true) {
                        await provider.loadAll();
                        if (!mounted) return;
                        // if a task was just added, attempt to select it by name
                        final filtered = _selectedProjectName == null
                            ? provider.tasks
                            : provider.tasks.where((t) {
                                final proj = provider.projects.firstWhere(
                                  (p) => p.name == _selectedProjectName,
                                  orElse: () => provider.projects.first,
                                );
                                return t.projectId == proj.id;
                              });
                        final tasks = filtered.toList();
                        if (tasks.isNotEmpty) {
                          setState(() {
                            _selectedTaskName = tasks.last.name;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter any additional notes',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Date
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTimeEntry,
                  child: const Text('Save Time Entry'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
