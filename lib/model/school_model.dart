class SchoolModel {
  late String id, name, address, gender, level, phone, adminName;
  SchoolModel(this.id, this.address, this.gender, this.level, this.name,
      this.phone, this.adminName);
  SchoolModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    address = map['address'];
    gender = map['gender'];
    level = map['level'];
    name = map['school_name'];
    phone = map['phone'];
    adminName = map['admin_name'];
  }
  toJson() {
    return {
      'id': id,
      'address': address,
      'gender': gender,
      'level': level,
      'school_name': name,
      'phone': phone,
      'admin_name': adminName
    };
  }
}
