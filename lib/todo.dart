class Todo {
  int? id;
  String task;
  bool isCompleted;

  Todo({this.id, required this.task, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      task: map['task'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
