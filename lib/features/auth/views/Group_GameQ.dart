import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/QQ_Rank.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';
import 'result_page.dart'; // Import the ResultsWidget (create it if not already)


class GroupGamePageWidget extends StatefulWidget {

  @override
  _GroupGamePageWidgetState createState() => _GroupGamePageWidgetState();
}

class _GroupGamePageWidgetState extends State<GroupGamePageWidget> {
  int currentQuestionIndex = 1;
  String? selectedAnswer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'The Pin number of a phone is formed from four numbers from 0 to 9. How many ways can it be formed?',
      'options': ['10000', '6500', '5040', '4000'],
      'correctAnswer': '10000',
    },
    {
      'question': 'What is the value of π (pi) approximately?',
      'options': ['3.14', '2.71', '1.62', '3.00'],
      'correctAnswer': '3.14',
    },
  ];

  List<String?> userAnswers = [];
  late int minutes;
  late int seconds;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    userAnswers = List<String?>.filled(questions.length, null);
    minutes = 0; // Set initial minutes for the timer
    seconds = 10;

    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else if (minutes > 0) {
          minutes--;
          seconds = 59;
        } else {
          // Timer is done, show dialog and navigate to RankPage
          _showTimeUpDialog();
          _timer.cancel();
        }
      });
    });
  }
  @override
  void dispose() {
    _timer.cancel(); // إيقاف التايمر عند مغادرة الصفحة
    super.dispose();
  }


  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Time\'s up!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    navigateToResultsPage(); // استدعاء الميثود مباشرة
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(232, 241, 174, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Go to Rank',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirm Quit?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentHomePage(), // Navigate to ConfigPage
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(232, 241, 174, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void navigateToResultsPage() {
    // إيقاف التايمر عند الانتقال إلى الصفحة
    _timer.cancel();

    int correctAnswers = 0;
    int skippedAnswers = 0;

    // حساب الإجابات الصحيحة والمفقودة
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == null) {
        skippedAnswers++;
      } else if (userAnswers[i] == questions[i]['correctAnswer']) {
        correctAnswers++;
      }
    }

    // حساب الإجابات الخاطئة
    int incorrectAnswers = questions.length - correctAnswers - skippedAnswers;

    // حساب نسبة الإنجاز
    double completionPercentage = ((questions.length - skippedAnswers) / questions.length) * 100;

    // حساب الدرجة
    String score = (correctAnswers * 10).toString();

    // الانتقال إلى صفحة RankPage مع تمرير البيانات
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RankPage(
          correctAnswers: correctAnswers,
          incorrectAnswers: incorrectAnswers,
          skippedAnswers: skippedAnswers,
          completionPercentage: completionPercentage,
          score: score,
          questions: questions, // تمرير الأسئلة
          userAnswers: userAnswers, // تمرير الإجابات
        ),
      ),
    );
  }







  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final currentQuestion = questions[currentQuestionIndex - 1];

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned(
            bottom: screenHeight * 0.02,
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
          // Exit Button
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                _timer.cancel(); // إيقاف التايمر عند الضغط على زر الخروج
                showExitConfirmationDialog(); // Show the confirmation dialog
              },
              child: Icon(
                Icons.arrow_back, // Use the exit icon
                size: screenWidth * 0.1, // Adjust the icon size
                color: Colors.redAccent, // Set the icon color
              ),
            ),
          ),


          // Timer Display
          Positioned(
            top: screenHeight * 0.1,
            right: screenWidth * 0.05,
            child: Text(
              '$minutes:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.01),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.175), // Adjust this to move the box down
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0EFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          currentQuestion['question'],
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    Positioned(
                      top: screenHeight * 0.1, // Adjust this value to move the number lower
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 4,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$currentQuestionIndex',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                ...List.generate(currentQuestion['options'].length, (index) {
                  final option = currentQuestion['options'][index];
                  final optionLetter = String.fromCharCode(97 + index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        userAnswers[currentQuestionIndex - 1] = option;
                        selectedAnswer = option;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswer == option
                                ? Colors.blue[400]
                                : Colors.blue[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: selectedAnswer == option
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -screenWidth * 0.03,
                          left: screenWidth * 0.02,
                          child: Container(
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.yellow[600],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                optionLetter,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: currentQuestionIndex > 1
                            ? () {
                          setState(() {
                            currentQuestionIndex--;
                            selectedAnswer =
                            userAnswers[currentQuestionIndex - 1];
                          });
                        }
                            : null,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: currentQuestionIndex > 1 ? Colors.black : Colors.grey,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                color: currentQuestionIndex > 1 ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: currentQuestionIndex < questions.length
                            ? () {
                          setState(() {
                            currentQuestionIndex++;
                            selectedAnswer =
                            userAnswers[currentQuestionIndex - 1];
                          });
                        }
                            : () {
                          navigateToResultsPage(); // Navigate to the results page
                        },
                        child: Row(
                          children: [
                            Text(
                              currentQuestionIndex < questions.length
                                  ? 'Next'
                                  : 'Finish',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
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
}
