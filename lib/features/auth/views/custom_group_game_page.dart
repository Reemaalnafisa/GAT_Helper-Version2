import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/GG_waiting.dart';
import 'package:gat_helper_app/features/auth/views/find_game_page.dart';

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
          // ✅ Background Image
          Positioned(
            top: -40,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/img.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // ✅ Title
          Positioned(
            top: 160,
            left: 20,
            child: Text(
              "Customize Your GROUP GAME!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // ✅ Main Content
          Positioned.fill(
            top: 210,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildOptionCard(
                      "Type of questions?",
                      [
                        _buildRadioOption("Verbal", selectedQuestionType, (value) {
                          setState(() {
                            selectedQuestionType = value;
                          });
                        }),
                        _buildRadioOption("Quantitative", selectedQuestionType, (value) {
                          setState(() {
                            selectedQuestionType = value;
                          });
                        }),
                      ],
                    ),

                    _buildOptionCard(
                      "Number of questions?",
                      [5, 10, 15, 20]
                          .map((num) => _buildRadioOption(num, selectedQuestionNumber, (value) {
                        setState(() {
                          selectedQuestionNumber = value;
                        });
                      }))
                          .toList(),
                    ),

                    _buildOptionCard(
                      "Timer of Game?",
                      [10, 15, 20, 30]
                          .map((num) => _buildRadioOption(num, selectedTimer, (value) {
                        setState(() {
                          selectedTimer = value;
                        });
                      }))
                          .toList(),
                    ),

                    // ✅ Participants Input
                    _buildInputCard("Number of participants", "Up to 10..."),

                    SizedBox(height: 10),

                    // ✅ Create Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE8F1AE),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LeaderWidget()),
                        );
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
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Widget to Build Custom Option Cards
  Widget _buildOptionCard(String title, List<Widget> options) {
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

  // ✅ Widget for Radio Button Options (FIXED)
  Widget _buildRadioOption(dynamic value, dynamic groupValue, Function(dynamic) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          activeColor: Colors.black,
          fillColor: MaterialStateProperty.all(Colors.black),
          onChanged: onChanged, // ✅ Correctly updates the state
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
