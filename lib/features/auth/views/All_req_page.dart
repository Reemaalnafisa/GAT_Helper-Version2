import 'package:flutter/material.dart';
import 'dart:async';

// Import your ChatPage here
import 'Student_chat_page.dart'; // Ensure this is the correct path to your ChatPage widget

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  Map<int, bool> showDetails = {};
  Map<int, int> ratings = {};
  late Future<List<Request>> requestsFuture;

  @override
  void initState() {
    super.initState();
    requestsFuture = fetchRequests();
  }

  Future<List<Request>> fetchRequests() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
    List<Request> requests = [
      Request(0, "Pending", "Sunday | 12:30 PM", Colors.yellow, "", false),
      Request(1, "Approved", "Sunday | 10:30 PM", Colors.green, "Approved by: Khalid Naif\n🔗 www.zoom.com\n⏳ 15 Min", false),
      Request(2, "Ended", "Sunday | 6:00 PM", Colors.grey, "Approved by: Nada Naser\nRate:", true),
      Request(3, "Approved", "Monday | 9:00 AM", Colors.green, "Approved by: Khalid Naif\n🗨️ Chat", false),
    ];

    // Sorting the requests based on the status
    requests.sort((a, b) {
      if (a.status == "Pending") return -1;
      if (b.status == "Pending") return 1;
      if (a.status == "Approved") return -1;
      if (b.status == "Approved") return 1;
      return 0; // If both are "Ended", they stay in the same order
    });

    return requests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Stack(
          children: [
            Image.asset(
              "assets/img_17.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 120,
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Requests",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Request>>(
        future: requestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final requests = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  return requestCard(
                    requests[index],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget requestCard(Request request) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: request.statusColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    request.status,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Text(request.time, style: TextStyle(color: Colors.grey[600])),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        setState(() {
                          showDetails[request.id] = !(showDetails[request.id] ?? false);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (showDetails[request.id] ?? false) ...[
              const SizedBox(height: 10),
              Text(request.details, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (request.details.contains('Chat')) ...[
                // Only show the clickable icon when "Chat" is in the details
                GestureDetector(
                  onTap: () {
                    // Navigate to ChatPage when the chat icon is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()), // Ensure the ChatPage is correctly imported
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align the icon to the right
                    children: [
                      Icon(Icons.chat, color: Colors.blue, size: 30), // Only the clickable chat icon
                    ],
                  ),
                ),
              ],
              if (request.showRating) ...[
                const SizedBox(height: 10),
                Row(
                  children: List.generate(
                    5,
                        (starIndex) => IconButton(
                      icon: Icon(
                        starIndex < (ratings[request.id] ?? 0)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          ratings[request.id] = starIndex + 1;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }
}

class Request {
  final int id;
  final String status;
  final String time;
  final Color statusColor;
  final String details;
  final bool showRating;

  Request(this.id, this.status, this.time, this.statusColor, this.details, this.showRating);
}
