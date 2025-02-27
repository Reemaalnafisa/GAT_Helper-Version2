import 'package:flutter/material.dart';

class RequestDetailsPage5 extends StatefulWidget {
  final String studentName;
  final String preferredMethod;

  // ✅ Constructor with required parameters
  const RequestDetailsPage5({
    Key? key,
    required this.studentName,
    required this.preferredMethod,
  }) : super(key: key);

  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage5> {
  int? selectedAnswer1;
  int? selectedAnswer2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Details"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Use `widget.studentName` and `widget.preferredMethod`
            Text(
              "Student: ${widget.studentName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Preferred Method: ${widget.preferredMethod}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // ✅ Scrollable Questions Section
            Expanded(
              child: SingleChildScrollView(
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
                  ],
                ),
              ),
            ),

            // ✅ Accept & Reject Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton("Reject", Colors.red, () {}),
                _actionButton("Accept", Colors.green, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Helper: Question Card Widget
  Widget _questionCard(String question, List<String> options, int? selectedValue, Function(int?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
                title: Text(options[index], style: TextStyle(fontSize: 13)),
                activeColor: Colors.blue,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Helper: Button Widget
  Widget _actionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
