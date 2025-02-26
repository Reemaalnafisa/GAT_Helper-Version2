import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/common/sign_up_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';
import 'package:gat_helper_app/features/common/edit_profile_page.dart';
import 'features/auth/views/All_req_page.dart';
import 'features/auth/views/GG_waiting.dart';
import 'features/auth/views/Group_GameQ.dart';
import 'features/auth/views/custom_group_game_page.dart';
import 'features/auth/views/find_game_page.dart';
import 'features/auth/views/request_link_page.dart';
import 'features/auth/views/self_game_config.dart';
import 'features/auth/views/tutor_chat_history_page.dart';
import 'features/auth/views/tutor_home_page.dart';

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
        debugShowCheckedModeBanner: false,
      home:  StartPage()

    );
  }
}

