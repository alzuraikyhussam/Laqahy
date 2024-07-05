class OfficeOrder {
  int? id;
  int? vaccineTypeId;
  int? officeId;
  int? quantity;
  int? orderStateId;
  String? orderStateName;
  String? vaccineType;
  String? officeName;
  String? officeNoteData;
  String? ministryNoteData;
  DateTime? orderDate;
  DateTime? deliveryDate;
  DateTime? updatedAt;

  OfficeOrder({
    this.id,
    this.vaccineTypeId,
    this.vaccineType,
    this.officeId,
    this.officeName,
    this.orderStateId,
    this.orderStateName,
    this.quantity,
    this.officeNoteData,
    this.deliveryDate,
    this.orderDate,
    this.ministryNoteData,
    this.updatedAt,
  });

  factory OfficeOrder.fromJson(Map<String, dynamic> json) {
    return OfficeOrder(
      id: json['id'] ?? 0,
      orderStateName: json['order_state'] ?? '',
      officeName: json['office_name'] ?? '',
      officeNoteData: json['office_note_data'] ?? '',
      ministryNoteData: json['ministry_note_data'] ?? '',
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      vaccineType: json['vaccine_type'] ?? '',
      quantity: json['quantity'] ?? 0,
      orderDate: json['order_date'] != null
          ? DateTime.parse(json['order_date'])
          : DateTime(1970, 1, 1), // default value if null
      deliveryDate: json['delivery_date'] != null
          ? DateTime.parse(json['delivery_date'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime(1970, 1, 1),
      officeId: json['office_id'] ?? 0,
      orderStateId: json['order_state_id'] ?? 0, // default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'office_id': officeId,
      'vaccine_type_id': vaccineTypeId,
      'quantity': quantity,
      'office_note_data': officeNoteData,
    };
  }
}
