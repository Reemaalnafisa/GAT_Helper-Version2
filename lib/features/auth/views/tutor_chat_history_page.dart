import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ChatHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> chatHistory = [
    {
      "name": "Nora Omar",
      "profile": "assets/img_1.png",
      "date": "Sunday 10:30 PM",
      "rating": 4.5,
      "status": "Active"
    },
    {
      "name": "Faisal Omar",
      "profile": "assets/profile2.png",
      "date": "Sunday 8:30 PM",
      "rating": 4.0,
      "status": ""
    },
    {
      "name": "Ahmed Omar",
      "profile": "assets/profile3.png",
      "date": "Sunday 6:00 PM",
      "rating": 3.8,
      "status": ""
    },
    {
      "name": "Huda Omar",
      "profile": "assets/profile4.png",
      "date": "Wednesday 5:34 PM",
      "rating": 4.2,
      "status": ""
    },
    {
      "name": "Yousef Hassan",
      "profile": "assets/profile5.png",
      "date": "Tuesday 11:26 PM",
      "rating": 3.5,
      "status": ""
    },
    {
      "name": "Dana Ibrahim",
      "profile": "assets/profile6.png",
      "date": "Monday 8:20 PM",
      "rating": 4.7,
      "status": ""
    },
    {
      "name": "Dana Ibrahim",
      "profile": "assets/profile6.png",
      "date": "Monday 8:20 PM",
      "rating": 4.7,
      "status": ""
    },
    {
      "name": "Dana Ibrahim",
      "profile": "assets/profile6.png",
      "date": "Monday 8:20 PM",
      "rating": 4.7,
      "status": ""
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat History"),
        backgroundColor: Color(0xFF284379),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: chatHistory.length,
          itemBuilder: (context, index) {
            var chat = chatHistory[index];
            return Card(
              color: Colors.blue.shade50,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    CircleAvatar(
                      backgroundColor: Colors.white, // White background for avatar
                      radius: 25,
                      child: ClipOval(
                        child: Image.asset(
                          chat["profile"],
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    // Chat Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name & Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  chat["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),

                          // Rating Stars
                          RatingBarIndicator(
                            rating: chat["rating"],
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 16,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10), // Space before the Active label and Arrow Icon

                    Align(
                      alignment: Alignment.topRight, // Moves to the top
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Prevents extra space
                        crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to the right
                        children: [
                          Text(
                            chat["date"],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (chat["status"] == "Active")
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Active",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        SizedBox(height: 8),

                        // Arrow Icon to navigate inside the chat
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: Colors.black54),
                          onPressed: () {
                            // Navigate to chat screen
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
