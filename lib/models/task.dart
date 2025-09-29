enum TaskType { ongoing, completed, overdue }

class Task {
  final int? id;
  final String title;
  final String? description;
  final DateTime deadline;
  DateTime? completedAt;

  Task({
    this.id,
    required this.title,
    required this.deadline,
    this.description,
    this.completedAt,
  });

  bool get isCompleted => completedAt != null;
  bool get isLate =>
      deadline.isAtSameMomentAs(DateTime.now()) ||
      deadline.isBefore(DateTime.now());
  bool get isOverdue => !isCompleted && isLate;

  String get leftTime {
    if (isCompleted) return '0m';
    final now = DateTime.now();
    final diff = deadline.difference(now);
    final duration = diff.abs();
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final buffer = StringBuffer();
    if (days > 0) buffer.write('${days}d ');
    if (hours > 0) buffer.write('${hours}h ');
    if (minutes > 0 || (days == 0 && hours == 0)) buffer.write('${minutes}m');
    return buffer.toString().trim();
  }

  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'deadline': deadline.millisecondsSinceEpoch,
    'description': description,
    'completed_at': completedAt?.millisecondsSinceEpoch,
  };

  factory Task.fromMap(Map<String, Object?> map) {
    if (!map.containsKey('title') || map['title'] is! String) {
      throw ArgumentError('Invalid or missing title');
    }
    if (!map.containsKey('deadline') || map['deadline'] is! int) {
      throw ArgumentError('Invalid or missing deadline');
    }
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
      description: (map['description'] as String?) ?? '',
      completedAt: map['completed_at'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['completed_at'] as int)
          : null,
    );
  }

  static List<Task> fromMaps(List<Map<String, Object?>> maps) =>
      maps.map(Task.fromMap).toList();

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? deadline,
    DateTime? completedAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    deadline: deadline ?? this.deadline,
    completedAt: completedAt ?? this.completedAt,
  );
}
