import 'package:flutter/material.dart';
import 'package:provider_student_management/db/database_helper.dart';
import 'package:provider_student_management/model/student_model.dart';
import 'package:provider_student_management/screens/student_details_page.dart';

class StudentListProvider extends ChangeNotifier {
  late DataBaseHelper dataBaseHelper;
  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isSearching = false;

  StudentListProvider() {
    dataBaseHelper = DataBaseHelper();
    refreshStudentList();
  }

  Future<void> refreshStudentList() async {
    final studentList = await dataBaseHelper.getStudents();
    students = studentList;
    filteredStudents = studentList;
    notifyListeners();
  }

  void fliterStudent(String query) {
    if (query.isEmpty) {
      filteredStudents = students;
    } else {
      filteredStudents = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      filteredStudents = students;
    }
    notifyListeners();
  }

  void navigateToStudentPage(Student data, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentDetailPage(student: data)));
  }
}
