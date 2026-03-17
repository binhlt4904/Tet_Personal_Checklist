class Task {
  final String? id; // đổi int -> String
  final String title;
  final String room;
  final String? description;
  final DateTime? deadline;
  bool isDone;

  Task({
    this.id,
    required this.title,
    required this.room,
    this.description,
    this.deadline,
    this.isDone = false,
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      room: json['room'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      isDone: json['is_done'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "room": room,
      "deadline": deadline?.toIso8601String(),
      "is_done": isDone,
    };
  }
  Task copyWith({
    String? id,
    String? title,
    String? room,
    String? description,
    DateTime? deadline,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      room: room ?? this.room,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isDone: isDone ?? this.isDone,
    );
  }
}