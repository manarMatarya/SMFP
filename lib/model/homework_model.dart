class HomeworkModel {
  late String subject_id, title, content, id, date, class_id;
  HomeworkModel(this.class_id, this.content, this.date, this.id,
      this.subject_id, this.title);
  HomeworkModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    subject_id = map['subject_id'];
    title = map['title'];
    content = map['content'];
    date = map['date'];
    class_id = map['class_id'];
  }
  toJson() {
    return {
      'id': id,
      'subject_id': subject_id,
      'title': title,
      'date': date,
      'content': content,
      'class_id': class_id,
    };
  }
}
