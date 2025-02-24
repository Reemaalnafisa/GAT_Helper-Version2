import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/GG_waiting.dart';
import 'package:gat_helper_app/features/auth/views/correct_answers_page.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
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
      'name': 'Ahmed',
      'points': '448 points',
      'avatar': 'assets/student.png',
      'rank': 5,
    },
    {
      'name': 'Ahmed',
      'points': '448 points',
      'avatar': 'assets/student.png',
      'rank': 6,
    },
    {
      'name': 'Ahmed',
      'points': '448 points',
      'avatar': 'assets/student.png',
      'rank': 8,
    },
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3C60AA),
      body: Column(
        children: [
          _buildCongratsAndScore(),
          SizedBox(height: 10),
          // The stack is used to layer the pink box below the columns.
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    // Show the top 3 contestants and columns
                    _buildTopThreeSection(),
                  ],
                ),
                // 1) Pink box at the bottom
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
                // Add ListView below the pink box
                Positioned(
                  top: 290, // Start from below the pink box
                  left: 0,
                  right: 0,
                  bottom: 0, // Allow the ListView to scroll
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
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Top 3 section (images + columns)
  Widget _buildTopThreeSection() {
    return Column(
      children: [
        // Top 3 contestants images
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (contestants[0]['rank'] <= 3)
              _buildRankInfo(contestants[0]['name'], contestants[0]['points'], contestants[0]['avatar']),
            SizedBox(width: 25),
            if (contestants[1]['rank'] <= 3)
              _buildRankInfo(contestants[1]['name'], contestants[1]['points'], contestants[1]['avatar']),
            SizedBox(width: 25),
            if (contestants[2]['rank'] <= 3)
              _buildRankInfo(contestants[2]['name'], contestants[2]['points'], contestants[2]['avatar']),
          ],
        ),

        SizedBox(height: 10),
        // Top 3 columns
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRankColumn(2, 'assets/rank2.png'),
            _buildRankColumn(1, 'assets/rank1.png'),
            _buildRankColumn(3, 'assets/rank3.png'),
          ],
        ),
      ],
    );
  }

  // Section for contestants with rank 4 and above
  Widget _buildOtherContestantsSection() {
    return Expanded(
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
    );
  }

  Widget _buildRankInfo(String name, String points, String avatarImage) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(avatarImage),
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

  // Function for congratulations and score
  Widget _buildCongratsAndScore() {
    return Stack(
      children: [
        // المحتوى الأساسي
        Column(
          children: [
            SizedBox(height: 50),  // Adjust this height to move content down
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
                    Text('1', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text('Skipped', style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 14)),
                    SizedBox(height: 4),
                    Text('1', style: TextStyle(color: Colors.white, fontSize: 16)),
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
                          questions: [
                            {
                              "question": "What is the capital of France?",
                              "correctAnswer": "Paris"
                            },
                            {
                              "question": "What is 2 + 2?",
                              "correctAnswer": "4"
                            }
                          ],
                          userAnswers: ["Paris", "5"], // Example user answers
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
                Row(
                  children: [
                    Icon(Icons.help_outline, color: Colors.white),
                    SizedBox(width: 5),
                    Text('Ask Tutor', style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ],
        ),

        // الأيقونات الثابتة في الأعلى
        Positioned(
          top: 20, // Adjust this to position icons correctly
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
          top: 20, // Adjust this to position icons correctly
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
