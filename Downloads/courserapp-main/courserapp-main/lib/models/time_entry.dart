class TimeEntry {
  final String id;
  final String projectName;
  final String taskName;
  final String notes;
  final DateTime date;
  final Duration totalTime;

  TimeEntry({
    required this.id,
    required this.projectName,
    required this.taskName,
    required this.notes,
    required this.date,
    required this.totalTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectName': projectName,
      'taskName': taskName,
      'notes': notes,
      'date': date.toIso8601String(),
      'totalTime': totalTime.inMinutes,
    };
  }

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectName: json['projectName'],
      taskName: json['taskName'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
      totalTime: Duration(minutes: json['totalTime']),
    );
  }

  String get formattedTime {
    final hours = totalTime.inHours;
    final minutes = totalTime.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }
}
