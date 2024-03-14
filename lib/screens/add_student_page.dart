import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_student_management/db/database_helper.dart';
import 'package:provider_student_management/model/student_model.dart';

class AddStudentPage extends StatefulWidget {
  final DataBaseHelper dataBaseHelper;

  const AddStudentPage({super.key, required this.dataBaseHelper});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parentnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _rollnumberController = TextEditingController();
  String? _profilePicture;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Student"),
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
                  setState(() {
                    image = img;
                  });
                  _profilePicture = image!.path;
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: _profilePicture != null
                      ? FileImage(File(_profilePicture!))
                      : null,
                  child: _profilePicture == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
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
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _rollnumberController,
                decoration: const InputDecoration(
                  labelText: 'Rollnumber',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your rollnumber';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final parentName = _parentnameController.text;
                    final age = int.parse(_ageController.text);
                    final rollnumber = int.parse(_rollnumberController.text);
                    final student = Student(
                      id: 0,
                      name: name,
                      age: age,
                      parentName: parentName,
                      rollnumber: rollnumber,
                      picture: _profilePicture ?? '',
                    );
                    widget.dataBaseHelper.insertStudents(student).then((id) {
                      if (id > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Student added successfully'),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to add student'),
                          ),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select a gender and fill in all fields.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
