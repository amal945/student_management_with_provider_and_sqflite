import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/providers/student_list_provider.dart';
import 'package:provider_student_management/screens/add_student_page.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentListProvider>(builder: (context, _, snapshot) {

      _.refreshStudentList();
      
      return Scaffold(
        appBar: AppBar(
          title: !_.isSearching
              ? const Text("Student List")
              : TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (query) {
                    _.fliterStudent(query);
                  },
                  decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
          actions: [
            IconButton(
                onPressed: () {
                  _.toggleSearch();
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: _.filteredStudents.isEmpty
            ? const Center(
                child: Text("No students"),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = _.filteredStudents[index];
                  return GestureDetector(
                    onTap: () {
                      _.navigateToStudentPage(student, context);
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30.0,
                            backgroundImage: student.picture.isNotEmpty
                                ? FileImage(File(student.picture))
                                : null,
                            child: student.picture.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                    size: 40,
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8.0),
                          Text(student.name),
                        ],
                      ),
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddStudentPage(dataBaseHelper: _.dataBaseHelper)),
            ).then((value) => _.refreshStudentList());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
