class SubjectModel {
  late String name, id;
  SubjectModel(this.id, this.name);
  SubjectModel.fromJson(map) {
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
