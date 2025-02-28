import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';
import 'self_game_page.dart'; // Import the SelfGamePageWidget file

class SelfgameconfigWidget extends StatefulWidget {
  @override
  _SelfgameconfigWidgetState createState() => _SelfgameconfigWidgetState();
}

class _SelfgameconfigWidgetState extends State<SelfgameconfigWidget> {
  bool isVerbalSelected = false;
  bool isQuantitativeSelected = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Top Background
          Positioned(
            top: -screenHeight * 0.10,
            left: -screenWidth * 0.8,
            right: -screenWidth * 0.8,
            child: Image.asset(
              'assets/upblue_background.png',
              fit: BoxFit.cover,
              width: screenWidth * 2.4,
              height: screenHeight * 0.40,
            ),
          ),
          // Back Arrow
          Positioned(
            top: screenHeight * 0.03,
            left: screenWidth * 0.03,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudentHomePage()), // Replace 'YourTargetPage' with the actual page you want to navigate to
                );
              },
              child: Icon(
                Icons.arrow_back,
                size: screenWidth * 0.08,
                color: Colors.white,
              ),
            ),
          ),
          // Bottom Backgrounds
          Positioned(
            bottom: screenHeight * 0,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Image.asset(
              'assets/yellow_background.png',
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
              'assets/downblue_background.png',
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
              'assets/Math.png',
              fit: BoxFit.cover,
              width: screenWidth * 1.2,
              height: screenHeight * 0.3,
            ),
          ),

          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(), // Push content lower
                SizedBox(height: screenHeight * 0.25),
                // Title
                Center(
                  child: Text(
                    'Customize Your Game!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // Question Type Title
                Center(
                  child: Text(
                    'Type of questions:',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Verbal Option Checkbox
                CheckboxListTile(
                  title: Text(
                    'Verbal',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                  value: isVerbalSelected,
                  onChanged: (value) {
                    setState(() {
                      isVerbalSelected = value!;
                    });
                  },
                ),
                // Quantitative Option Checkbox
                CheckboxListTile(
                  title: Text(
                    'Quantitative',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black,
                    ),
                  ),
                  value: isQuantitativeSelected,
                  onChanged: (value) {
                    setState(() {
                      isQuantitativeSelected = value!;
                    });
                  },
                ),
                Spacer(), // Push the button lower
                // Get Started Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: screenWidth * 0.05,
                      bottom: screenHeight * 0.25, // 🔼 Increased this value to move the button UP
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isVerbalSelected && !isQuantitativeSelected) {
                          // Show SnackBar if no option is selected
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please select at least one option!',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Collect selected options
                          List<String> selectedOptions = [];
                          if (isVerbalSelected) selectedOptions.add('Verbal');
                          if (isQuantitativeSelected) {
                            selectedOptions.add('Quantitative');
                          }

                          // Navigate to SelfGamePageWidget and pass the selected options
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelfGamePageWidget(
                                selectedOptions: selectedOptions,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFF176),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Let\'s Started',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
