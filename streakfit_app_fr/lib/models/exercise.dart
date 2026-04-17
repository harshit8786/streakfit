class Exercise {
  final String id;
  final String title;
  final String description;
  final int duration;
  final String target;
  final String day;
  Exercise({required this.id, required this.title, required this.description, required this.duration, required this.target, required this.day});
  static int _parseDuration(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.round();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
  factory Exercise.fromJson(Map<String,dynamic> j) => Exercise(
    id: j['_id'] ?? j['id'] ?? '',
    title: j['title'] ?? '',
    description: j['description'] ?? '',
    duration: _parseDuration(j['duration']),
    target: j['target'] ?? '',
    day: j['day'] ?? '',
  );
}
