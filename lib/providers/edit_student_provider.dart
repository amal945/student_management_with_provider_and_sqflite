import 'package:flutter/material.dart';
import 'package:provider_student_management/screens/student_list_page.dart';

class EditStudentProvider extends ChangeNotifier {
  String? profilePicturePath;
  // XFile? image;

  void setImage(String img) {
    // image = img;
    profilePicturePath = img;
    notifyListeners();
  }

  void clearImage() {
    // image = null; 
    profilePicturePath = null;
    notifyListeners();
  }

  void validationSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Updated successfully.")),
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const StudentListPage()),
        (route) => false);
  }

  void validationFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Unsuccessful")),
    );
  }
}
