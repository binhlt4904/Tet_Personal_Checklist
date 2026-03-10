class RoomTipModel {
  final String title;
  final String description;
  final String time;
  final String icon;
  final List<String> steps;
  final List<String> tools;

  RoomTipModel({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.steps,
    required this.tools,
  });
}