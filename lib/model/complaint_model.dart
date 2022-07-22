class ComplaintModel {
  late String title, content, schoolId, parentId;
  ComplaintModel(this.title, this.content, this.schoolId, this.parentId);
  ComplaintModel.fromJson(map) {
    if (map == null) {
      return;
    }
    title = map['title'];
    content = map['content'];
    schoolId = map['school_id'];
    parentId = map['parent_id'];
  }
  toJson() {
    return {
      'title': title,
      'content': content,
      'school_id': schoolId,
      'parent_id': parentId,
    };
  }
}
