class Todo {
  final String id;
  String title;
  Priority priority;

  Todo(this.id);
}

  enum Priority {
    low,
    medium,
    high
  }