
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/edit_student_provider.dart';
import 'providers/splash_provider.dart';
import 'providers/student_detail_provider.dart';
import 'providers/student_list_provider.dart';
import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudentRecordApp());
}

class StudentRecordApp extends StatelessWidget {
  const StudentRecordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => StudentListProvider()),
        ChangeNotifierProvider(create: (_) => StudentDetailProvider()),
        ChangeNotifierProvider(create: (_) => EditStudentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Student Record",
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}
