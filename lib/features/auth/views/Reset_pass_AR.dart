import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/common/Reset_pass_page2.dart';

import 'Reset_pass_AR2.dart';

class ResetPassAR extends StatelessWidget {
  const ResetPassAR({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl, // Set text direction to RTL for Arabic
        child: Stack(
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            // PNG Image Button (Positioned in the top-right and slightly up)
            Positioned(
              left: 30, // Adjust based on your layout
              top: screenHeight * 0.7,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPassAR2(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10), // Add padding around the image
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent, // Keeps the background transparent
                  ),
                  child: Image.asset(
                    'assets/img_19.png',
                    width: 48,
                    height: 48,
                  ),
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
                      const SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          'إعادة تعيين كلمة المرور',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Email Input
                      const Text(
                        'أدخل بريدك الإلكتروني:',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'البريد الإلكتروني',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
