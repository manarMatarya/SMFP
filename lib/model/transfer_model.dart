class TransferModel {
  late String currentSchool,
      toSchool,
      name,
      reason,
      average,
      grade,
      firstAccept,
      secondAccept;
  TransferModel(this.name, this.toSchool, this.currentSchool, this.reason,
      this.average, this.grade, this.firstAccept, this.secondAccept);
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
    firstAccept = map['first_accept'];
    secondAccept = map['second_accept'];
  }
  toJson() {
    return {
      'name': name,
      'to_school_id': currentSchool,
      'current_school_id': toSchool,
      'reason': reason,
      'average': average,
      'grade': grade,
      'first_accept': firstAccept,
      'second_accept': secondAccept,
    };
  }
}
