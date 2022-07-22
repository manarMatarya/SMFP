class TeacherModel {
  late String name, image, id, phone, schoolId, subjectId;
  late List classes;
  TeacherModel(this.id, this.name, this.image, this.phone, this.schoolId,
      this.subjectId, this.classes);
  TeacherModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    name = map['name'];
    image = map['image'];
    phone = map['phone'];
    schoolId = map['school_id'];
    subjectId = map['subject_id'];
    classes = map['classes'];
  }
  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'phone': phone,
      'school_id': schoolId,
      'subject_id': subjectId,
      'classes': classes
    };
  }
}
