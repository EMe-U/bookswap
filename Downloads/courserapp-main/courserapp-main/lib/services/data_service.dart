import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';

class DataService {
  static const String _timeEntriesKey = 'time_entries';
  static const String _projectsKey = 'projects';
  static const String _tasksKey = 'tasks';

  // Time Entries
  static Future<List<TimeEntry>> getTimeEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList(_timeEntriesKey) ?? [];
    return entriesJson
        .map((json) => TimeEntry.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> saveTimeEntry(TimeEntry entry) async {
    final entries = await getTimeEntries();
    entries.add(entry);
    await _saveTimeEntries(entries);
  }

  static Future<void> deleteTimeEntry(String id) async {
    final entries = await getTimeEntries();
    entries.removeWhere((entry) => entry.id == id);
    await _saveTimeEntries(entries);
  }

  static Future<void> _saveTimeEntries(List<TimeEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = entries
        .map((entry) => jsonEncode(entry.toJson()))
        .toList();
    await prefs.setStringList(_timeEntriesKey, entriesJson);
  }

  // Projects
  static Future<List<Project>> getProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final projectsJson = prefs.getStringList(_projectsKey) ?? [];
    return projectsJson
        .map((json) => Project.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> saveProject(Project project) async {
    final projects = await getProjects();
    projects.add(project);
    await _saveProjects(projects);
  }

  static Future<void> deleteProject(String id) async {
    final projects = await getProjects();
    projects.removeWhere((project) => project.id == id);
    await _saveProjects(projects);
  }

  static Future<void> _saveProjects(List<Project> projects) async {
    final prefs = await SharedPreferences.getInstance();
    final projectsJson = projects
        .map((project) => jsonEncode(project.toJson()))
        .toList();
    await prefs.setStringList(_projectsKey, projectsJson);
  }

  // Tasks
  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((json) => Task.fromJson(jsonDecode(json))).toList();
  }

  static Future<void> saveTask(Task task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await _saveTasks(tasks);
  }

  static Future<void> deleteTask(String id) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    await _saveTasks(tasks);
  }

  static Future<void> _saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_tasksKey, tasksJson);
  }

  // Get tasks for a specific project
  static Future<List<Task>> getTasksForProject(String projectId) async {
    final allTasks = await getTasks();
    return allTasks.where((task) => task.projectId == projectId).toList();
  }

  // Clear all data (for testing)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_timeEntriesKey);
    await prefs.remove(_projectsKey);
    await prefs.remove(_tasksKey);
  }
}
