import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/db/database_helper.dart';
import 'package:provider_student_management/model/student_model.dart';
import 'package:provider_student_management/providers/student_detail_provider.dart';

// ignore: must_be_immutable
class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({super.key, required this.student});
  DataBaseHelper db = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentDetailProvider>(builder: (context, _, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Student Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _.deleteBox(context, student);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _.navigateToEditStudentPage(context, student);
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: FileImage(File(student.picture)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Name: ${student.name}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Age: ${student.age}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Parent Name: ${student.parentName}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Rollnumber: ${student.rollnumber}',
                style: const TextStyle(fontSize: 18.0),
              ),
            )
          ],
        ),
      );
    });
  }
}
