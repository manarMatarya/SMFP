// ignore_for_file: non_constant_identifier_names

class StudentModel {
  late String name,
      image,
      id,
      class_id,
      grade,
      birthday,
      gender,
      school_id,
      parent_id;
  StudentModel(this.id, this.name, this.image, this.class_id, this.grade,
      this.birthday, this.gender, this.school_id, this.parent_id);
  StudentModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    name = map['name'];
    image = map['image'];
    class_id = map['class_id'];
    grade = map['grade'];
    birthday = map['birthday'];
    gender = map['gender'];
    school_id = map['school_id'];
    parent_id = map['parent_id'];
  }
  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'class_id': class_id,
      'grade': grade,
      'birthday': birthday,
      'gender': gender,
      'school_id': school_id,
      'parent_id': parent_id,
    };
  }
}
