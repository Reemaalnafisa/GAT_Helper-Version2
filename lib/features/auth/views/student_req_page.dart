import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';

class Studentreq extends StatefulWidget {
  const Studentreq({super.key});

  @override
  State<Studentreq> createState() => _StudentreqState();
}

class _StudentreqState extends State<Studentreq> {
  // For Dropdown
  String? _selectedOption;
  List<String> _dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];

  // For Radio Buttons
  String? _radioValue = 'Option A';

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
              'assets/img_12.png',
              fit: BoxFit.cover,
              width: screenWidth * 2.4,
              height: screenHeight * 0.40,
            ),
          ),

          // Text on top of the top background
          Positioned(
            top: screenHeight * 0.15, // Adjust this value to move text lower or higher
            left: screenWidth * 0.1,  // Adjust left alignment
            right: screenWidth * 0.1, // Adjust right alignment if needed
            child: Center(
              child: Text(
                'We’re here to support you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Istok Web',
                  fontSize: 24,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
          ),

          // Bottom Background
          Positioned(
            bottom: screenHeight * 0.01,
            left: screenWidth * 0.15,
            right: screenWidth * 0.15,
            child: Image.asset(
              'assets/img_13.png',
              fit: BoxFit.cover,
              width: screenWidth * 0.7,
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
                        "Request Details",
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Gender Dropdown
                    const Text(
                      'Questions:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 6.0),
                    DropdownButtonFormField<String>(
                      value: _selectedOption,
                      decoration: InputDecoration(
                        hintText: 'Questions',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: _dropdownOptions.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),


                    const SizedBox(height: 20),

                    // Radio Buttons
                    Text(
                      'Preferred method:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Space out the radio buttons
                      children: <Widget>[
                        // Left Radio Button
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Chat',
                              groupValue: _radioValue,
                              onChanged: (String? value) {
                                setState(() {
                                  _radioValue = value;
                                });
                              },
                            ),
                            Text('Chat'),
                          ],
                        ),
                        // Spacer (Control the spacing here)
                        SizedBox(width: 80),
                        // Right Radio Button
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Virtual',
                              groupValue: _radioValue,
                              onChanged: (String? value) {
                                setState(() {
                                  _radioValue = value;
                                });
                              },
                            ),
                            Text('Virtual'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),

                    // Send Button
                    Center(
                      child: SizedBox(
                        height: 48.0,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            // Show a SnackBar for confirmation
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Request sent successfully!'),
                                duration: Duration(seconds: 2), // How long the message is displayed
                              ),
                            );

                            // Delay the navigation so the user sees the notification first
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => StudentHomePage()), // Replace with your target page
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen, // Green color
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      ),
                    ),
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