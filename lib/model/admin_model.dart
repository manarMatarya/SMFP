class AdminModel {
  late String adminName, schoolName, id, phone, address, gender, level;
  AdminModel(this.id, this.adminName, this.schoolName, this.phone, this.address,
      this.gender, this.level);
  AdminModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    adminName = map['admin_name'];
    schoolName = map['school_name'];
    phone = map['phone'];
    address = map['address'];
    gender = map['gender'];
    level = map['level'];
  }
  toJson() {
    return {
      'id': id,
      'admin_name': adminName,
      'school_name': schoolName,
      'phone': phone,
      'address': address,
      'gender': gender,
      'level': level
    };
  }
}
