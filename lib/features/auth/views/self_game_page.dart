import 'package:flutter/material.dart';
import 'self_game_config.dart'; // Import the ConfigPage
import 'result_page.dart'; // Import the ResultsWidget (create it if not already)

class SelfGamePageWidget extends StatefulWidget {
  final List<String> selectedOptions;

  SelfGamePageWidget({required this.selectedOptions});

  @override
  _SelfGamePageWidgetState createState() => _SelfGamePageWidgetState();
}

class _SelfGamePageWidgetState extends State<SelfGamePageWidget> {
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

  @override
  void initState() {
    super.initState();
    userAnswers = List<String?>.filled(questions.length, null);
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
                        builder: (context) => SelfgameconfigWidget(), // Navigate to ConfigPage
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
    // Calculate the number of correct, incorrect, and skipped answers
    int correctAnswers = 0;
    int skippedAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == null) {
        skippedAnswers++;
      } else if (userAnswers[i] == questions[i]['correctAnswer']) {
        correctAnswers++;
      }
    }

    int incorrectAnswers = questions.length - correctAnswers - skippedAnswers;

    // Calculate completion percentage
    double completionPercentage =
        ((questions.length - skippedAnswers) / questions.length) * 100;

    // Calculate score (for example, score = correct answers * 10)
    String score = (correctAnswers * 10).toString();

    // Navigate to the ResultsWidget with the calculated data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsWidget(
          correctAnswers: correctAnswers,
          incorrectAnswers: incorrectAnswers,
          skippedAnswers: skippedAnswers,
          completionPercentage: completionPercentage,
          score: score,
          questions: questions, // Pass the list of questions
          userAnswers: userAnswers, // Pass the user's answers
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
                showExitConfirmationDialog(); // Show the confirmation dialog
              },
              child: Image.asset(
                'assets/exit_logo.png',
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
              ),
            ),
          ),
          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
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
                    Positioned(
                      top: -screenWidth * 0.075,
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
                    ),
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