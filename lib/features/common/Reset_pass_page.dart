import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/common/Reset_pass_page2.dart';

class ResetPassWidget extends StatelessWidget {
  const ResetPassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
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
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          // PNG Image Button (Positioned in the top-right and slightly up)
          Positioned(
            right: 16,  // Right margin
            top: screenHeight * 0.7,  // Adjust top margin to move it up
            child: GestureDetector(
              onTap: () {
                // Navigate to ResetPassWidget2 when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPassWidget2(),
                  ),
                );
              },
              child: Image.asset(
                'assets/img_14.png',  // The PNG image
                width: 48,  // You can adjust the size of the image
                height: 48,
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
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Email Input
                    const Text(
                      'Enter your Email:',
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

                    const SizedBox(height: 30.0),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}