class AttendanceModel {
  // ignore: non_constant_identifier_names
  late String student_id, status, reason, date;
  AttendanceModel(
    this.student_id,
    this.status,
    this.date,
    this.reason,
  );
  AttendanceModel.fromJson(map) {
    if (map == null) {
      return;
    }
    student_id = map['student_id'];
    status = map['status'];
    reason = map['reason'];

    date = map['date'];
  }
  toJson() {
    return {
      'student_id': student_id,
      'status': status,
      'reason': reason,
      'date': date,
    };
  }
}
