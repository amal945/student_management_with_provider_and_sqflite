
import 'package:flutter/material.dart';
import 'package:provider_student_management/db/database_helper.dart';
import 'package:provider_student_management/model/student_model.dart';
import 'package:provider_student_management/screens/edit_student_page.dart';
import 'package:provider_student_management/screens/student_list_page.dart';

class StudentDetailProvider extends ChangeNotifier {
  DataBaseHelper db = DataBaseHelper();

  void deleteBox(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: const Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              db.deleteStudent(student.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Deleted successfully.")),
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const StudentListPage()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }

  navigateToEditStudentPage(BuildContext context,Student student){
    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditStudentPage(student: student),
                  ),
                ).then((_) => Navigator.pop(context));
  }
}
