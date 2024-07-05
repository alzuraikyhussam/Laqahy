class CenterOrder {
  int? id;
  int? vaccineTypeId;
  int? centerId;
  int? quantity;
  int? orderStateId;
  String? orderStateName;
  String? vaccineType;
  String? centerName;
  String? officeNoteData;
  String? centerNoteData;
  DateTime? orderDate;
  DateTime? deliveryDate;
  DateTime? updatedAt;

  CenterOrder({
    this.id,
    this.vaccineTypeId,
    this.vaccineType,
    this.centerId,
    this.centerName,
    this.orderStateId,
    this.orderStateName,
    this.quantity,
    this.officeNoteData,
    this.deliveryDate,
    this.orderDate,
    this.centerNoteData,
    this.updatedAt,
  });

  factory CenterOrder.fromJson(Map<String, dynamic> json) {
    return CenterOrder(
      id: json['id'] ?? 0,
      orderStateName: json['order_state'] ?? '',
      centerName: json['healthy_center_name'] ?? '',
      officeNoteData: json['office_note_data'] ?? '',
      centerNoteData: json['center_note_data'] ?? '',
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
      centerId: json['healthy_center_id'] ?? 0,
      orderStateId: json['order_state_id'] ?? 0, // default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'office_note_data': officeNoteData,
    };
  }
}
