import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/sign_up_page.dart';
import 'package:gat_helper_app/features/auth/views/start_page.dart';
import 'package:gat_helper_app/features/common/edit_profile_page.dart';

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
      home: const StartPage()

    );
  }
}

