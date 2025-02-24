import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/common/sign_up_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';
import 'package:gat_helper_app/features/common/sign_up_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';
import 'package:gat_helper_app/features/common/edit_profile_page.dart';
import 'package:gat_helper_app/features/auth/views/student_req_page.dart';

import 'features/auth/views/All_req_page.dart';
import 'features/auth/views/Parent_home_page.dart';
import 'features/auth/views/Sign_up_page_AR.dart';
import 'features/auth/views/Student_chat_page.dart';
import 'features/auth/views/login_page_AR.dart';
import 'package:gat_helper_app/features/common/student_home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gat Helpper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const StartPage(),





    );
  }
}

