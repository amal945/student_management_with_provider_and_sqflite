import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/db/database_helper.dart';
import 'package:provider_student_management/model/student_model.dart';
import 'package:provider_student_management/providers/edit_student_provider.dart';

class EditStudentPage extends StatelessWidget {
  final Student student;

  EditStudentPage({super.key, required this.student});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _parentnameController = TextEditingController();

  final _rollnumberController = TextEditingController();

  final _profilePictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DataBaseHelper databaseHelp = DataBaseHelper();
    final editStudentProvider = Provider.of<EditStudentProvider>(context);
    editStudentProvider.setImage(student.picture.toString());
    _nameController.text = student.name;
    _ageController.text = student.age.toString();
    _parentnameController.text = student.parentName;
    _rollnumberController.text = student.rollnumber.toString();
    _profilePictureController.text = student.picture;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? img = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (img != null) {
                    editStudentProvider.setImage(img.toString());
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: editStudentProvider.profilePicturePath !=
                          null
                      ? FileImage(File(editStudentProvider.profilePicturePath!))
                      : FileImage(File(student.picture)),
                  child: _profilePictureController.text.isEmpty
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter valid name.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0 || age > 100) {
                    return 'Invalid age. Age must be between 1 and 100.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _parentnameController,
                decoration: const InputDecoration(
                  labelText: "Parent Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Valid input";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _rollnumberController,
                decoration: const InputDecoration(labelText: 'Rollnumber'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rollnumber';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final age = int.parse(_ageController.text);
                    final rollnumber = int.parse(_rollnumberController.text);
                    final parentName = _parentnameController.text;
                    final updatedStudent = Student(
                      id: student.id,
                      name: name,
                      age: age,
                      parentName: parentName,
                      rollnumber: rollnumber,
                      picture: editStudentProvider.profilePicturePath != null
                          ? editStudentProvider.profilePicturePath!
                          : "",
                    );

                    databaseHelp.updateStudent(updatedStudent).then((id) {
                      if (id > 0) {
                        editStudentProvider.validationSuccess(context);
                      } else {
                        editStudentProvider.validationFailed(context);
                      }
                    });
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
