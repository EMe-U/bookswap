import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import 'data_service.dart';

class DemoDataService {
  static Future<void> populateDemoData() async {
    // Clear existing data
    await DataService.clearAllData();

    // Create sample projects
    final project1 = Project(
      id: '1',
      name: 'Mobile App Development',
      description: 'Flutter mobile application project',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    );

    final project2 = Project(
      id: '2',
      name: 'Web Dashboard',
      description: 'React web dashboard for analytics',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    );

    final project3 = Project(
      id: '3',
      name: 'API Backend',
      description: 'Node.js REST API development',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    );

    await DataService.saveProject(project1);
    await DataService.saveProject(project2);
    await DataService.saveProject(project3);

    // Create sample tasks
    final task1 = Task(
      id: '1',
      name: 'UI Design',
      description: 'Design user interface components',
      projectId: '1',
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    );

    final task2 = Task(
      id: '2',
      name: 'Database Setup',
      description: 'Set up database schema and migrations',
      projectId: '1',
      createdAt: DateTime.now().subtract(const Duration(days: 22)),
    );

    final task3 = Task(
      id: '3',
      name: 'Frontend Components',
      description: 'Build React components for dashboard',
      projectId: '2',
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
    );

    final task4 = Task(
      id: '4',
      name: 'API Endpoints',
      description: 'Create REST API endpoints',
      projectId: '3',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    );

    final task5 = Task(
      id: '5',
      name: 'Authentication',
      description: 'Implement user authentication',
      projectId: '3',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    );

    await DataService.saveTask(task1);
    await DataService.saveTask(task2);
    await DataService.saveTask(task3);
    await DataService.saveTask(task4);
    await DataService.saveTask(task5);

    // Create sample time entries
    final entry1 = TimeEntry(
      id: '1',
      projectName: 'Mobile App Development',
      taskName: 'UI Design',
      notes: 'Worked on login screen design',
      date: DateTime.now().subtract(const Duration(days: 5)),
      totalTime: const Duration(hours: 3, minutes: 30),
    );

    final entry2 = TimeEntry(
      id: '2',
      projectName: 'Mobile App Development',
      taskName: 'Database Setup',
      notes: 'Configured SQLite database',
      date: DateTime.now().subtract(const Duration(days: 4)),
      totalTime: const Duration(hours: 2, minutes: 15),
    );

    final entry3 = TimeEntry(
      id: '3',
      projectName: 'Web Dashboard',
      taskName: 'Frontend Components',
      notes: 'Built chart components',
      date: DateTime.now().subtract(const Duration(days: 3)),
      totalTime: const Duration(hours: 4, minutes: 45),
    );

    final entry4 = TimeEntry(
      id: '4',
      projectName: 'API Backend',
      taskName: 'API Endpoints',
      notes: 'Created user management endpoints',
      date: DateTime.now().subtract(const Duration(days: 2)),
      totalTime: const Duration(hours: 5, minutes: 20),
    );

    final entry5 = TimeEntry(
      id: '5',
      projectName: 'API Backend',
      taskName: 'Authentication',
      notes: 'Implemented JWT authentication',
      date: DateTime.now().subtract(const Duration(days: 1)),
      totalTime: const Duration(hours: 2, minutes: 30),
    );

    await DataService.saveTimeEntry(entry1);
    await DataService.saveTimeEntry(entry2);
    await DataService.saveTimeEntry(entry3);
    await DataService.saveTimeEntry(entry4);
    await DataService.saveTimeEntry(entry5);
  }

  static Future<void> clearAllData() async {
    await DataService.clearAllData();
  }
}
