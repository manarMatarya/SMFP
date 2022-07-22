import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBReference {
  final FirebaseAuth auth = FirebaseAuth.instance;

  static CollectionReference studentCollectionRef =
      FirebaseFirestore.instance.collection('Student');
  static CollectionReference teacherRef =
      FirebaseFirestore.instance.collection('Teacher');
  static CollectionReference classCollectionRef =
      FirebaseFirestore.instance.collection('Class');
  static CollectionReference schoolCollectionRef =
      FirebaseFirestore.instance.collection('School');

  static CollectionReference parentRef =
      FirebaseFirestore.instance.collection('Parent');
  static CollectionReference eventsCollectionRef =
      FirebaseFirestore.instance.collection('Event');

  static CollectionReference subjectCollectionRef =
      FirebaseFirestore.instance.collection('Subject');
  static CollectionReference examCollectionRef =
      FirebaseFirestore.instance.collection('Exam');
  static CollectionReference resultCollectionRef =
      FirebaseFirestore.instance.collection('ExamResult');
  static CollectionReference semesterCollectionRef =
      FirebaseFirestore.instance.collection('Semester');

  static CollectionReference homeworkCollectionRef =
      FirebaseFirestore.instance.collection('Homework');

  static CollectionReference weekSchedualeCollectionRef =
      FirebaseFirestore.instance.collection('WeeklySchedule');
  static CollectionReference attendanceCollectionRef =
      FirebaseFirestore.instance.collection('Attendance');

  static CollectionReference messageRef =
      FirebaseFirestore.instance.collection('messages');
}
