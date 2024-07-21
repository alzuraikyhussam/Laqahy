class Login {
  int? id;
  String? motherName;
  String? phoneNum;
  String? identityNum;
  String? passWord;
  String? healthCenterName;
  int? healthCenterId;
  String? village;
  DateTime? birthDate;
  String? directorate;
  String? city;
  String? token;

  Login({
    this.id,
    this.motherName,
    this.phoneNum,
    this.passWord,
    this.birthDate,
    this.city,
    this.directorate,
    this.village,
    this.identityNum,
    this.healthCenterId,
    this.healthCenterName,
    this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'],
      motherName: json['mother_name'],
      phoneNum: json['mother_phone'],
      passWord: json['mother_password'],
      village: json['mother_village'],
      birthDate: json['mother_birthDate'] != null
          ? DateTime.parse(json['mother_birthDate'])
          : DateTime(1970, 1, 1),
      city: json['city_name'],
      identityNum: json['mother_identity_num'],
      directorate: json['directorate_name'],
      healthCenterId: json['healthy_center_id'],
      healthCenterName: json['healthy_center_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'mother_identity_num': identityNum,
      'mother_password': passWord,
      'mother_phone': phoneNum,
      'mother_id': id,
      'token': token,
    };
  }
}
