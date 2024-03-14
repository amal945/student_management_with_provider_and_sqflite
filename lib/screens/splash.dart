import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/providers/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false)
        .gotoStudentListPage(context);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://i.pinimg.com/736x/a1/52/5a/a1525aa2c74d1eb05bf1f41234727bcf.jpg'))),
        ),
      ),
    );
  }
}
