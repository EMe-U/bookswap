import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../services/data_service.dart';
import 'home_screen.dart';
import 'add_time_entry_screen.dart';
import 'add_project_screen.dart';
import 'task_management_screen.dart';
import 'project_management_screen.dart';

class LocalStorageScreen extends StatefulWidget {
  const LocalStorageScreen({super.key});

  @override
  State<LocalStorageScreen> createState() => _LocalStorageScreenState();
}

class _LocalStorageScreenState extends State<LocalStorageScreen> {
  List<TimeEntry> _timeEntries = [];
  List<Project> _projects = [];
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final timeEntries = await DataService.getTimeEntries();
    final projects = await DataService.getProjects();
    final tasks = await DataService.getTasks();

    setState(() {
      _timeEntries = timeEntries;
      _projects = projects;
      _tasks = tasks;
      _isLoading = false;
    });
  }

  Future<void> _clearAllData() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text(
            'Are you sure you want to clear all data? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await DataService.clearAllData();
                await _loadData();
              },
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.storage, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No data stored locally',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some projects, tasks, and time entries to see them here',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDataSection<T>(
    String title,
    List<T> items,
    Widget Function(T) itemBuilder,
  ) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text('${items.length} items'),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                ),
              ],
            ),
          ),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No $title.toLowerCase() found',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            )
          else
            ...items.map((item) => itemBuilder(item)),
        ],
      ),
    );
  }

  Widget _buildTimeEntryItem(TimeEntry entry) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Text(
          entry.formattedTime,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(entry.projectName),
      subtitle: Text('${entry.taskName} - ${entry.formattedDate}'),
      isThreeLine: false,
    );
  }

  Widget _buildProjectItem(Project project) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Text(
          project.name[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(project.name),
      subtitle: Text(project.description),
      isThreeLine: false,
    );
  }

  Widget _buildTaskItem(Task task) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Text(
          task.name[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(task.name),
      subtitle: Text(task.description),
      isThreeLine: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final teal = const Color(0xFF2E8B85);

    void openAddOptions() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Add Time Entry'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTimeEntryScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Add Project'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProjectScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.task),
                  title: const Text('Add Task'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TaskManagementScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: teal),
              child: Center(
                child: Text(
                  'Menu',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Projects'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProjectManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tasks'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TaskManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Storage'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: teal,
        centerTitle: true,
        title: const Text('Local Storage'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearAllData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _timeEntries.isEmpty && _projects.isEmpty && _tasks.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildDataSection(
                    'Time Entries',
                    _timeEntries,
                    _buildTimeEntryItem,
                  ),
                  _buildDataSection('Projects', _projects, _buildProjectItem),
                  _buildDataSection('Tasks', _tasks, _buildTaskItem),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddOptions,
        tooltip: 'Add',
        backgroundColor: Colors.amber[600],
        child: const Icon(Icons.add),
      ),
    );
  }
}
