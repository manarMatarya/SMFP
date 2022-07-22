class ExamModel {
  late String subjectId, examType, id, date, time, name, grade, semesterId;
  late double total, result;
  ExamModel(this.id, this.subjectId, this.examType, this.date, this.time,
      this.name, this.total, this.result, this.grade, this.semesterId);
  ExamModel.fromJson(map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    subjectId = map['subject_id'];
    examType = map['exam_type'];
    date = map['date'];
    time = map['time'];
    name = map['name'];
    semesterId = map['semester_id'];
  }
  toJson() {
    return {
      'id': id,
      'subject_id': subjectId,
      'exam_type': examType,
      'date': date,
      'time': time,
      'name': name,
      'semester_id': semesterId
    };
  }
}
