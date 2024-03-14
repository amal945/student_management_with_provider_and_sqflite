import 'package:flutter/material.dart';
import 'package:provider_student_management/screens/student_list_page.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> gotoStudentListPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StudentListPage())));
  }
}
