import 'package:flutter/material.dart';

class GroupGamePage extends StatefulWidget {
  @override
  _GroupGamePageState createState() => _GroupGamePageState();
}

class _GroupGamePageState extends State<GroupGamePage> {
  TextEditingController _codeController = TextEditingController();

  final List<Map<String, dynamic>> groupGames = [
    {"id": 1, "name": "Lama Saud", "type": "Verbal Questions", "players": "8 / 10", "time": "5"},
    {"id": 2, "name": "Abdullah Fahad", "type": "Verbal and Quantitative Questions", "players": "4 / 10", "time": "10"},
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
          // ✅ PNG Header Image at the Top
          Image.asset(
            'assets/img.png', // Make sure this file exists in your assets folder
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // ✅ Title + Input Field + "+" Button
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0), // 🔼 Moves it up but keeps spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // ✅ Aligns title to the left
              children: [
                Text(
                  "Find Your Group Game!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10), // 🔼 Keeps a small gap below the title

                // Input Field & "+" Button
                Row(
                  children: [
                    // Input Field with Submit Button Inside
                    Expanded(
                      child: TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          hintText: "Enter a Code...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25), // ✅ Rounder corners
                            borderSide: BorderSide(color: Colors.black, width: 2), // ✅ Black border
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // ✅ Adjust padding

                          // ✅ Arrow Icon inside TextField (on the right)
                          suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_forward_ios, color: Colors.black), // ✅ Arrow icon
                            onPressed: () {
                              // Action when arrow is clicked
                            },
                          ),
                        ),
                      )

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
                          // Navigate to Create Game Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateGamePage()),
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
                              SizedBox(width: 15),
                              Icon(Icons.timer, color: Colors.black, size: 16),
                              SizedBox(width: 5),
                              Text(
                                game["time"] + " min",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                      onTap: () {
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
