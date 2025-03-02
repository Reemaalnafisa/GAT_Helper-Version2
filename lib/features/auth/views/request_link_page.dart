import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/tutor_home_page.dart';

class SessionLinkPage extends StatefulWidget {
  @override
  _SessionLinkPageState createState() => _SessionLinkPageState();
}

class _SessionLinkPageState extends State<SessionLinkPage> {
  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Rounded Header
          Stack(
            children: [
              Image.asset(
                "assets/img_17.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
              ),
              Positioned(
                top: 45,
                left: 125,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/img_1.png"), // Profile Image
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Sara Omar", // Tutor Name
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 80), // Adjusted space below the header

          // Enlarged Centered Input Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50), // **Bigger box**
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10), // Square shape
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Enter Session Link",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _linkController,
                      decoration: InputDecoration(
                        hintText: "Link...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40), // Space before button

          // Send Button (Fixed Syntax)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE8F1AE), // Light Yellow Color
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Square Button
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Link sent successfully!'),
                  duration: Duration(seconds: 2), // How long the message is displayed
                ),
              );

              // Delay the navigation so the user sees the notification first
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TutorHomepage()), // Replace with your target page
                );
              });
            },
            child: Text(
              "Send",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
