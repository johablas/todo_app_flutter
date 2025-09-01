import 'dart:convert';

class Task {
  String title;
  String description;
  bool completed;

  Task({
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Convierte Task a Map (para JSON)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  // Convierte Map a Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      completed: map['completed'],
    );
  }

  // JSON string
  String toJson() => json.encode(toMap());

  // De JSON string a Task
  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source));
}


