class PermissionType {
  int? id;
  String permissionType;

  PermissionType({
    this.id,
    required this.permissionType,
  });

  factory PermissionType.fromJson(Map<String, dynamic> json) {
    return PermissionType(
      id: json['id'],
      permissionType: json['permission_type'],
    );
  }
}
