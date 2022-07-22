class SemesterModel {
  late String id, name;
  SemesterModel(this.id, this.name);
  SemesterModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    name = map['name'];
  }
  toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
