import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/GG_waiting.dart';
import 'package:gat_helper_app/features/auth/views/correct_answers_page.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';
import 'package:gat_helper_app/features/auth/views/student_req_page.dart';
import 'package:confetti/confetti.dart';  // تأكد من الاستيراد الصحيح
import 'dart:math';

class RankPage extends StatefulWidget {
  final int correctAnswers;
  final int incorrectAnswers;
  final int skippedAnswers;
  final double completionPercentage;
  final String score;
  final List<Map<String, dynamic>> questions;
  final List<String?> userAnswers;

  RankPage({
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.skippedAnswers,
    required this.completionPercentage,
    required this.score,
    required this.questions,
    required this.userAnswers,
  });

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play(); // تشغيل الطراطيع عند بداية الصفحة
  }

  @override
  void dispose() {
    _confettiController.dispose(); // التأكد من التخلص منها عند مغادرة الصفحة
    super.dispose();
  }

  List<Map<String, dynamic>> contestants = [
    {
      'name': 'Saad',
      'points': '2,569 QP',
      'avatar': 'assets/student.png',
      'rank': 1,
    },
    {
      'name': 'Sara',
      'points': '1,469 QP',
      'avatar': 'assets/student.png',
      'rank': 2,
    },
    {
      'name': 'Osama',
      'points': '1,053 QP',
      'avatar': 'assets/student.png',
      'rank': 3,
    },
    {
      'name': 'Nora',
      'points': '590 points',
      'avatar': 'assets/student.png',
      'rank': 4,
    },
    {
      'name': 'Ahmed A',
      'points': '448 points',
      'avatar': 'assets/student.png',
      'rank': 5,
    },
    {
      'name': 'Ahmed B',
      'points': '448 points',
      'avatar': 'assets/student.png',
      'rank': 6,
    },
    {
      'name': 'Ahmed C',
      'points': '448 points',
      'avatar': 'assets/student.png',
      'rank': 7,
    },
    {
      'name': 'Laila',
      'points': '300 points',
      'avatar': 'assets/student.png',
      'rank': 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3C60AA),
      body: Stack(
        children: [
          // ConfettiWidget for confetti animation when page loads
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi ,
            emissionFrequency: 0.4,
            numberOfParticles: 30,
            blastDirectionality: BlastDirectionality.explosive,
            gravity: 0.1,
            colors: const [
              Colors.blueAccent,
              Colors.pinkAccent,
              Colors.orangeAccent,
              Colors.purpleAccent,
            ],
          ),
          Column(
            children: [
              _buildCongratsAndScore(),
              SizedBox(height: 10),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10),
                        _buildTopThreeSection(),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 210,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 330, // Adjust the starting position to fit inside the pink area
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: ListView.builder(
                          itemCount: contestants.length - 3, // Remaining contestants
                          itemBuilder: (context, index) {
                            var contestant = contestants[index + 3]; // Start from rank 4
                            return _buildAdditionalRank(
                              contestant['name'],
                              contestant['points'],
                              contestant['avatar'],
                              contestant['rank'],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopThreeSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRankInfo(contestants[1]['name'], contestants[1]['points'], contestants[1]['avatar'], 1),
            SizedBox(width: 40),
            _buildRankInfo(contestants[0]['name'], contestants[0]['points'], contestants[0]['avatar'], 2),
            SizedBox(width: 40),
            _buildRankInfo(contestants[2]['name'], contestants[2]['points'], contestants[2]['avatar'], 3),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRankColumn(2, 'assets/rank2.png'),
            _buildRankColumn(1, 'assets/rank1.png'),
            Container(
              height: 250,
              padding: EdgeInsets.only(top: 50),
              child: _buildRankColumn(3, 'assets/rank3.png'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRankInfo(String name, String points, String avatarImage, int rank) {
    double topPadding = 0.0;
    if (rank == 1) {
      topPadding = 20;
    } else if (rank == 3) {
      topPadding = 30;
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(avatarImage),
              ),
            ),
            if (rank == 2)
              Positioned(
                top: -10,
                right: -10,
                child: Icon(
                  Icons.wine_bar_sharp,
                  color: Colors.yellow,
                  size: 40,
                ),
              ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(
          points,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Color(0xFFB3B3B3)),
        ),
      ],
    );
  }

  Widget _buildRankColumn(int rank, String podiumImage) {
    double height = 150.0;
    if (rank == 1) {
      height = 250.0;
    } else if (rank == 2) {
      height = 200.0;
    } else {
      height = 250;
    }

    return Container(
      width: 110,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(podiumImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildAdditionalRank(String name, String points, String avatarImage, int rank) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  '$rank',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 16),
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(avatarImage),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(width: 9),
              Text(
                points,
                style: TextStyle(color: Color(0xFFB3B3B3)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCongratsAndScore() {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                'Congratulations!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '8 / 10',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Incorrect Answers', style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 14)),
                    SizedBox(height: 4),
                    Text('${widget.incorrectAnswers}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text('Skipped Answers', style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 14)),
                    SizedBox(height: 4),
                    Text('${widget.skippedAnswers}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CorrectAnswersPage(
                          questions: widget.questions,
                          userAnswers: widget.userAnswers,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('Check Correct Answers', style: TextStyle(fontSize: 12)),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Studentreq(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.white),
                      SizedBox(width: 5),
                      Text('Ask Tutor', style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentHomePage()),
              );
            },
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.refresh, color: Colors.white, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderWidget()),
              );
            },
          ),
        ),
      ],
    );
  }
}
