import 'package:flutter/material.dart';

class CustomizeGamePage extends StatefulWidget {
  @override
  _CustomizeGamePageState createState() => _CustomizeGamePageState();
}

class _CustomizeGamePageState extends State<CustomizeGamePage> {
  String? selectedQuestionType = "Verbal";
  int? selectedQuestionNumber = 10;
  int? selectedTimer = 15;
  TextEditingController _participantsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Green Topper PNG (Background)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/img_2.png', // ✅ Ensure this file exists in assets
              width: double.infinity,
              fit: BoxFit.cover,

            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 90,
            left: 20,
            child: Text(
              "Customize Your GROUP GAME!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // ✅ Main Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 150), // ✅ Space to move blue cards up

                // ✅ Game Customization Options (Blue Cards)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildOptionCard(
                        "Type of questions?",
                        [
                          _buildRadioOption("Verbal", selectedQuestionType),
                          _buildRadioOption("Quantitative", selectedQuestionType),
                        ],
                            (value) {
                          setState(() {
                            selectedQuestionType = value;
                          });
                        },
                      ),

                      _buildOptionCard(
                        "Number of questions?",
                        [5, 10, 15, 20]
                            .map((num) => _buildRadioOption(num, selectedQuestionNumber))
                            .toList(),
                            (value) {
                          setState(() {
                            selectedQuestionNumber = value;
                          });
                        },
                      ),

                      _buildOptionCard(
                        "Timer of Game?",
                        [10, 15, 20, 30]
                            .map((num) => _buildRadioOption(num, selectedTimer))
                            .toList(),
                            (value) {
                          setState(() {
                            selectedTimer = value;
                          });
                        },
                      ),

                      // ✅ Participants Input
                      _buildInputCard("Number of participants", "Up to 10..."),

                      SizedBox(height: 10),

                      // ✅ Create Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE8F1AE), // Light yellow button
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Action for creating the game
                        },
                        child: Text(
                          "CREATE",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),

                      SizedBox(height: 20),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  // ✅ Widget to Build Custom Option Cards
  Widget _buildOptionCard(String title, List<Widget> options, Function onChanged) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14, color: Colors.black)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options,
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Widget for Radio Button Options
  Widget _buildRadioOption(dynamic value, dynamic groupValue) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          activeColor: Colors.black,
          fillColor: MaterialStateProperty.all(Colors.black),
          onChanged: (val) {
            setState(() {
              groupValue = val;
            });
          },
        ),
        Text(
          value.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  // ✅ Widget for Input Card
  Widget _buildInputCard(String title, String hint) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14, color: Colors.black)),
            SizedBox(height: 10),
            TextField(
              controller: _participantsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
