import 'package:flutter/material.dart';
import 'sign_up_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/logo2.png', // Replace with the path to your app logo
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'GAT HELPER',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Buttons
            _buildRoleButton(context, 'Student'),
            const SizedBox(height: 20),
            _buildRoleButton(context, 'Parent'),
            const SizedBox(height: 20),
            _buildRoleButton(context, 'Tutor'),
          ],
        ),
      ),
    );
  }

  // Helper function to build a button
  Widget _buildRoleButton(BuildContext context, String role) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the SignUpPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpPage(), // Navigation to SignUpPage
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreen, // Button color
        minimumSize: const Size(200, 50), // Button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        role,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
