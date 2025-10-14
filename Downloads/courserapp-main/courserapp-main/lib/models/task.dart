class Task {
  final String id;
  final String name;
  final String description;
  final String projectId;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.projectId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'projectId': projectId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      projectId: json['projectId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
