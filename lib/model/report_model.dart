class ReportModel {
  late String school_id, title, content, date_created, student_id;
  ReportModel(this.student_id, this.content, this.date_created, this.school_id,
      this.title);
  ReportModel.fromJson(map) {
    if (map == null) {
      return;
    }

    school_id = map['school_id'];
    title = map['title'];
    content = map['content'];

    date_created = map['date_created'];
    student_id = map['student_id'];
  }
  toJson() {
    return {
      'school_id': school_id,
      'title': title,
      'date_created': date_created,
      'content': content,
      'student_id': student_id,
    };
  }
}
