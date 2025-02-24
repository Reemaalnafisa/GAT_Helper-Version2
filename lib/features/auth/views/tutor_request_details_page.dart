import 'package:flutter/material.dart';

class RequestDetailsPage extends StatefulWidget {
  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  int? selectedAnswer1;
  int? selectedAnswer2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Rounded Top Bar
          Stack(
            children: [
              ClipPath(
                clipper: CustomAppBarClipper(),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                top: 70,
                left: 20,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Request Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  _questionCard(
                    "The Pin number of a phone is formed from four numbers (0 to 9). How many ways can it be formed?",
                    ["10000", "6500", "5040", "4000"],
                    selectedAnswer1,
                        (value) => setState(() => selectedAnswer1 = value),
                  ),
                  SizedBox(height: 15), // Adjusted spacing

                  _questionCard(
                    "FALLING : GRAVITATION",
                    [
                      "collapse : destruction",
                      "balloon : sky",
                      "pressure : air",
                      "electricity : lamp"
                    ],
                    selectedAnswer2,
                        (value) => setState(() => selectedAnswer2 = value),
                  ),
                  SizedBox(height: 30), // Extra spacing before buttons
                ],
              ),
            ),
          ),

          // Accept & Reject Buttons Fixed at Bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _actionButton("Reject", Colors.red, () {}),
                    _actionButton("Accept", Colors.green, () {}),
                  ],
                ),
                SizedBox(height: 50), // White space under buttons
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Smaller Question Card
  Widget _questionCard(String question, List<String> options, int? selectedValue, Function(int?) onChanged) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Reduced height
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12), // Smaller rounded edges
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: Colors.black54, size: 18),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 5), // Smaller spacing

          Column(
            children: List.generate(
              options.length,
                  (index) => RadioListTile<int>(
                value: index,
                groupValue: selectedValue,
                onChanged: onChanged,
                title: Text(options[index], style: TextStyle(fontSize: 13)), // Adjusted text size
                activeColor: Colors.blue,
                contentPadding: EdgeInsets.zero, // Removed extra padding
                dense: true, // Makes it more compact
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Button Widget
  Widget _actionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}

// Custom Clipper for Rounded AppBar
class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
