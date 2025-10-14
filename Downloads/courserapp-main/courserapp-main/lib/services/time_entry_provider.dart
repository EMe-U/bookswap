import 'package:flutter/foundation.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import 'data_service.dart';

class TimeEntryProvider extends ChangeNotifier {
  List<TimeEntry> _entries = [];
  List<Project> _projects = [];
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<TimeEntry> get entries => _entries;
  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> loadAll() async {
    _isLoading = true;
    notifyListeners();

    _entries = await DataService.getTimeEntries();
    _projects = await DataService.getProjects();
    _tasks = await DataService.getTasks();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProject(Project project) async {
    await DataService.saveProject(project);
    await loadAll();
  }

  Future<void> addTask(Task task) async {
    await DataService.saveTask(task);
    await loadAll();
  }

  Future<void> addEntry(TimeEntry entry) async {
    await DataService.saveTimeEntry(entry);
    await loadAll();
  }

  Future<void> deleteEntry(String id) async {
    await DataService.deleteTimeEntry(id);
    await loadAll();
  }
}
