class AwarenessInformation {
  final int? id;
  final String title;
  final String description;

  AwarenessInformation({
    required this.title,
    required this.description,
    this.id,
  });

  factory AwarenessInformation.fromJson(Map<String, dynamic> json) {
    return AwarenessInformation(
      id: json['id'] ?? 0,
      title: json['awareness_title'] ?? '',
      description: json['awareness_description'] ?? '',
    );
  }
}
