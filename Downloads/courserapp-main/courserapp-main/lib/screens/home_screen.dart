import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../services/time_entry_provider.dart';
import 'add_time_entry_screen.dart';
import 'add_project_screen.dart';
import 'add_task_screen.dart';
import 'project_management_screen.dart';
import 'task_management_screen.dart';
import 'local_storage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _confirmDelete(TimeEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this time entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await context.read<TimeEntryProvider>().deleteEntry(entry.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 120, color: Colors.grey[300]),
          const SizedBox(height: 24),
          Text(
            'No time entries yet!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first entry.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _entryCard(BuildContext context, TimeEntry entry) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            entry.formattedTime,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(entry.projectName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task: ${entry.taskName}'),
            if (entry.notes.isNotEmpty) Text('Notes: ${entry.notes}'),
            Text('Date: ${entry.formattedDate}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _confirmDelete(entry),
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _groupedView(List<TimeEntry> entries) {
    final grouped = <String, List<TimeEntry>>{};
    for (final e in entries) {
      grouped.putIfAbsent(e.projectName, () => []).add(e);
    }
    if (grouped.isEmpty) return _emptyState(context);
    return ListView(
      children: grouped.entries
          .map(
            (g) => Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      g.key,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...g.value.map((e) => _entryCard(context, e)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  void _openAddOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Time Entry'),
              onTap: () async {
                Navigator.of(context).pop();
                final provider = context.read<TimeEntryProvider>();
                final res = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTimeEntryScreen()),
                );
                if (res == true) {
                  await provider.loadAll();
                  if (!mounted) return;
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Add Project'),
              onTap: () async {
                Navigator.of(context).pop();
                final provider = context.read<TimeEntryProvider>();
                final res = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddProjectScreen()),
                );
                if (res == true) {
                  await provider.loadAll();
                  if (!mounted) return;
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Add Task'),
              onTap: () async {
                Navigator.of(context).pop();
                final provider = context.read<TimeEntryProvider>();
                final res = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTaskScreen()),
                );
                if (res == true) {
                  await provider.loadAll();
                  if (!mounted) return;
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Storage'),
              onTap: () async {
                Navigator.of(context).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocalStorageScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teal = const Color(0xFF2E8B85);
    final provider = context.watch<TimeEntryProvider>();
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
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Projects'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProjectManagementScreen(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tasks'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TaskManagementScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Storage'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LocalStorageScreen()),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: teal,
        centerTitle: true,
        title: const Text('Time Tracking'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber[600],
          tabs: const [
            Tab(text: 'All Entries'),
            Tab(text: 'Grouped by Projects'),
          ],
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                provider.entries.isEmpty
                    ? _emptyState(context)
                    : ListView(
                        children: provider.entries
                            .map((e) => _entryCard(context, e))
                            .toList(),
                      ),
                _groupedView(provider.entries),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddOptions,
        tooltip: 'Add',
        backgroundColor: Colors.amber[600],
        child: const Icon(Icons.add),
      ),
    );
  }
}
