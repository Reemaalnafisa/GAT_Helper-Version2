import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';
import 'package:gat_helper_app/features/common/login_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';

import '../auth/views/Sign_up_page_AR.dart';

class SignUpPage extends StatefulWidget {
  final String userRole; // User Role parameter

  const SignUpPage({super.key, required this.userRole});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedGender;
  String? _selectedGrade;
  final List<String> _genders = ['Male', 'Female'];
  final List<String> _grades = ['10', '11', '12']; // Grade levels for students

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Images in a Column
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
          Positioned(
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

          // SafeArea for Back Button to ensure it's always on top
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => StartPage()),);
                },
              ),
            ),
          ),

          // Main Content
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Welcome!',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, height: -7),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Center(
                      child: Text(
                        "Let's get started!",
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600, height: -3),
                      ),
                    ),
                    const SizedBox(height: 39.0),

                    // Name Input
                    _buildLabel('Name'),
                    _buildTextField(hintText: 'Enter your name', screenWidth: screenWidth),

                    // Email Input
                    _buildLabel('Email'),
                    _buildTextField(hintText: 'Enter your email', screenWidth: screenWidth),

                    // Password Input
                    _buildLabel('Password'),
                    _buildTextField(hintText: 'Enter your password', screenWidth: screenWidth, obscureText: true),

                    // Gender Dropdown
                    _buildLabel('Gender'),
                    _buildDropdown(
                      value: _selectedGender,
                      items: _genders,
                      hint: 'Select gender',
                      onChanged: (value) => setState(() => _selectedGender = value),
                      screenWidth: screenWidth,
                    ),

                    // Grade Level Dropdown (Only for Students)
                    if (widget.userRole == 'student') ...[
                      _buildLabel('Grade Level'),
                      _buildDropdown(
                        value: _selectedGrade,
                        items: _grades,
                        hint: 'Select grade level',
                        onChanged: (value) => setState(() => _selectedGrade = value),
                        screenWidth: screenWidth,
                      ),
                    ],

                    const SizedBox(height: 10.0),

                    // Sign Up Button
                    Center(
                      child: SizedBox(
                        height: 40.0,
                        width: screenWidth * 0.9, // Adjusted width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const StudentHomePage()),);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0, // Reduced font size
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Login Link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account?",
                          style: const TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.lightBlue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push( //here
                                  MaterialPageRoute(builder: (_) => LoginPage(userRole: widget.userRole,)),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Language Toggle Button, show only for Parent Role
          if (widget.userRole == 'parent')
            Positioned(
              bottom: screenHeight * 0.15, // Adjusted to bring it closer to the bottom
              left: screenWidth * 0.40,    // Centered horizontally
              child: Center(
                child: IconButton(
                  icon: Image.asset('assets/img_18.png', width: 40, height: 40), // Smaller size
                  iconSize: 40, // Smaller size
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SignUpPageAR(userRole: 'parent')),
                    );
                  },
                ),
              ),
            ),

        ],
      ),
    );
  }

  // Helper method to build input labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 4.0),
      child: Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({required String hintText, required double screenWidth, bool obscureText = false}) {
    return SizedBox(
      width: screenWidth * 0.9, // Adjusted width
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0), // Compressed field height
        ),
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  // Helper method to build dropdowns
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
    required double screenWidth,
  }) {
    return SizedBox(
      width: screenWidth * 0.9, // Adjusted width
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: 14.0)))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
