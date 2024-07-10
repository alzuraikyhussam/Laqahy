class OrderState {
  int? id;
  String state;

  OrderState({
    this.id,
    required this.state,
  });

  factory OrderState.fromJson(Map<String, dynamic> json) {
    return OrderState(
      id: json['id'] ?? 0,
      state: json['order_state'] ?? '',
    );
  }
}
