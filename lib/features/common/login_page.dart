import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';
import 'package:gat_helper_app/features/common/Reset_pass_page.dart';
import 'package:gat_helper_app/features/auth/views/Sign_up_page_AR.dart';
import 'package:gat_helper_app/features/auth/views/login_page_AR.dart';
import 'package:gat_helper_app/features/common/sign_up_page.dart';

import '../auth/views/Parent_home_page.dart';
import '../auth/views/Sign_up_page_AR.dart';
import '../auth/views/tutor_home_page.dart'; // Ensure this is imported

class LoginPage extends StatefulWidget {
  final String userRole; // Add user role

  const LoginPage({super.key, required this.userRole});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Top Background
          Positioned(
            top: -screenHeight * 0.10,
            left: -screenWidth * 0.8,
            right: -screenWidth * 0.8,
            child: Image.asset(
              'assets/img_12.png',
              fit: BoxFit.cover,
              width: screenWidth * 2.4,
              height: screenHeight * 0.40,
            ),
          ),

          // Bottom Backgrounds yellow
          Positioned(
            bottom: screenHeight * 0,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Image.asset(
              'assets/img_11.png',
              fit: BoxFit.cover,
              width: screenWidth * 1.2,
              height: screenHeight * 0.4,
            ),
          ),
          Positioned( // Down blue
            bottom: 0,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Image.asset(
              'assets/img_10.png',
              fit: BoxFit.cover,
              width: screenWidth * 1.2,
              height: screenHeight * 0.35,
            ),
          ),

          // Math Image
          Positioned(
            bottom: -screenHeight * 0.12,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Image.asset(
              'assets/img_9.png',
              fit: BoxFit.cover,
              width: screenWidth * 1.2,
              height: screenHeight * 0.3,
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpPage(userRole: widget.userRole,)),);
                },
              ),
            ),
          ),

          // Main Content Centered
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 50.0), // Adjusts position

                    // Welcome Text
                    Center(
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Center(
                      child: Text(
                        "Glad to see you!",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email Input
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Input
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    Center(
                      child: SizedBox(
                        height: 48.0,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the corresponding home page based on the userRole
                            if (widget.userRole == 'student') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const StudentHomePage()),
                              );
                            } else if (widget.userRole == 'tutor') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => TutorHomepage()),
                              );
                            }
                            else if (widget.userRole == 'parent') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => ParentHomePage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10.0),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Forgot password?",
                          style: TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                              text: ' Change Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return ResetPassWidget();
                                    },
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Language Toggle Button, show only for Parent Role
          if (widget.userRole.trim().toLowerCase() == 'parent')
              Positioned(
                bottom: screenHeight * 0.15, // Adjusted to bring it closer to the bottom
                left: screenWidth * 0.40,    // Centered horizontally
                child: Center(
                  child: IconButton(
                    icon: Image.asset('assets/img_18.png', width: 40, height: 40), // Smaller size
                    iconSize: 40, // Smaller size
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPageAR(userRole: 'parent',)),
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
