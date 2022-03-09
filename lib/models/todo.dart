import 'dart:convert';

class TodoTask {
  int? id;
  final String task;
  final DateTime dateTime;
  TodoTask({
    this.id,
    required this.task,
    required this.dateTime,
  });

  TodoTask copyWith({
    int? id,
    String? task,
    DateTime? dateTime,
  }) {
    return TodoTask(
      id: id ?? this.id,
      task: task ?? this.task,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'dateTime': dateTime.toString(),
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
      id: map['id']?.toInt(),
      task: map['task'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoTask.fromJson(String source) => TodoTask.fromMap(json.decode(source));

  @override
  String toString() => 'TodoTask(id: $id, task: $task, dateTime: $dateTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TodoTask &&
      other.id == id &&
      other.task == task &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode => id.hashCode ^ task.hashCode ^ dateTime.hashCode;
}
