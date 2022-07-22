class EventModel {
  // ignore: non_constant_identifier_names
  late String school_id, title, date, image;
  EventModel(this.school_id, this.image, this.title, this.date);
  EventModel.fromJson(map) {
    if (map == null) {
      return;
    }
    school_id = map['school_id'];
    title = map['title'];
    image = map['image'];
    date = map['date'];
  }
  toJson() {
    return {
      'school_id': school_id,
      'title': title,
      'date': date,
      'image': image,
    };
  }
}
