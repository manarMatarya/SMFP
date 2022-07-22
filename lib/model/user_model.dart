class ParentModel {
  late String address, phone, id, name,image;
  ParentModel(this.id, this.name, this.phone, this.address,this.image);
  ParentModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    address = map['address'];
    image = map['image'];
  }
  toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'image':image
    };
  }
}
