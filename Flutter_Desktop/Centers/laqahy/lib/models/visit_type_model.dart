class VisitType {
  int? id;
  String visit_period	;

  VisitType({
    this.id,
    required this.visit_period,
  });

  factory VisitType.fromJson(Map<String, dynamic> json) {
    return VisitType(
      id: json['id'],
      visit_period: json['visit_period'],
    );
  }
}