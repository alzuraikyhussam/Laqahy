class Notifications {
  final int? id;
  final String title;
  final String description;
  final DateTime date;

  Notifications({
    required this.title,
    required this.description,
    required this.date,
    this.id,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'] ?? 0,
      title: json['notification_title'] ?? '',
      description: json['notification_description'] ?? '',
      date: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }
}
