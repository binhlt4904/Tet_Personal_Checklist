import '../../domain/entities/task.dart';

class TaskDto {
  final int? id;
  final String title;
  final String room;
  final String? deadline;
  final String? description;
  final int isDone;

  TaskDto({
    this.id,
    required this.title,
    required this.room,
    this.deadline,
    this.description,
    required this.isDone,
  });

  factory TaskDto.fromEntity(Task t) => TaskDto(
    id: t.id,
    title: t.title,
    room: t.room,
    deadline: t.deadline?.toIso8601String(),
    description: t.description,
    isDone: t.isDone ? 1 : 0,
  );

  Task toEntity() => Task(
    id: id,
    title: title,
    room: room,
    deadline:
    deadline != null ? DateTime.parse(deadline!) : null,
    description: description,
    isDone: isDone == 1,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'room': room,
    'deadline': deadline,
    'description': description,
    'isDone': isDone,
  };

  factory TaskDto.fromMap(Map<String, dynamic> map) => TaskDto(
    id: map['id'],
    title: map['title'],
    room: map['room'],
    description: map['description'],
    deadline: map['deadline'],
    isDone: map['isDone'],
  );
}