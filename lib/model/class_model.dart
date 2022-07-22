class ClassModel {
  late String name, id;
  ClassModel(this.id, this.name);
  ClassModel.fromJson(map) {
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
