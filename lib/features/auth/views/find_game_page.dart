import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/custom_group_game_page.dart';

import 'GG_waiting.dart';
import 'Ques_group.dart';

class GroupGamePage extends StatefulWidget {
  @override
  _GroupGamePageState createState() => _GroupGamePageState();
}

class _GroupGamePageState extends State<GroupGamePage> {
  TextEditingController _codeController = TextEditingController();

  final List<Map<String, dynamic>> groupGames = [
    {"id": 1, "name": "Lama Saud", "type": "Verbal Questions", "players": "8 / 10", "time": "5"},
    {"id": 2, "name": "Abdullah Fahad", "type": "Verbal & Quantitative Questions", "players": "4 / 10", "time": "10"},
    {"id": 3, "name": "Layan Ahmed", "type": "Quantitative Questions", "players": "3 / 5", "time": "15"},
    {"id": 4, "name": "Yara Bader", "type": "Quantitative Questions", "players": "3 / 7", "time": "10"},
    {"id": 5, "name": "Mohamed Yaser", "type": "Quantitative Questions", "players": "2 / 10", "time": "5"},
    {"id": 6, "name": "Jana Khalid", "type": "Quantitative Questions", "players": "9 / 10", "time": "20"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ✅ Back Arrow Overlayed on Top of the Image
          Stack(
            children: [
              // ✅ Background Image
              Image.asset(
                'assets/img.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              // ✅ Back Button Positioned on Top of the Image
              Positioned(
                top: 40, // Adjust for better placement
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context), // Navigate back
                  child:Icon(Icons.arrow_back, color: Colors.black, size: 24),
                  ),
                ),
            ],
          ),

          // ✅ Title + Input Field + "+" Button
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Your Group Game!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Input Field & "+" Button
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          hintText: "Enter a Code...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GroupGameques()),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    // "+" Button for Creating a New Game
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CustomizeGamePage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ✅ Scrollable Group Game List
          Expanded(
            child: ListView.builder(
              itemCount: groupGames.length,
              itemBuilder: (context, index) {
                var game = groupGames[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  child: Card(
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          game["id"].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        game["name"],
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game["type"],
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.people, color: Colors.black, size: 16),
                              SizedBox(width: 5),
                              Text(
                                game["players"],
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 7),
                              Icon(Icons.timer, color: Colors.black, size: 16),
                              SizedBox(width: 5),
                              Text(
                                game["time"] + " min",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 7), // Spacing before the game code
                              Row(
                                children: [
                                  Icon(Icons.vpn_key, color: Colors.black, size: 16), // Key icon
                                  SizedBox(width: 5),
                                  Text(
                                    "Code: ${game["code"]}", // Display game code
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LeaderWidget()),
                        );
                        // Navigate to game details page
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Placeholder for the Create Game Page
class CreateGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a New Game")),
      body: Center(child: Text("Game Creation Page (Coming Soon)")),
    );
  }
}