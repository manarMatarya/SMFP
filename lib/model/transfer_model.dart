class TransferModel {
  late String currentSchool, toSchool, name, reason,average,grade;
  TransferModel(this.name, this.toSchool, this.currentSchool, this.reason,this.average, this.grade);
  TransferModel.fromJson(map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    toSchool = map['to_school_id'];
    currentSchool = map['current_school_id'];
    average = map['average'];
    reason = map['reason'];
    grade = map['grade'];

  }
  toJson() {
    return {
      'name': name,
      'to_school_id': currentSchool,
      'current_school_id': toSchool,
      'reason': reason,
      'average':average,
      'grade':grade

    };
  }
}
