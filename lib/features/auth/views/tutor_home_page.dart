import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/tutor_request_details_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TutorHomepage(),
  ));
}

// Main Tutor Homepage
class TutorHomepage extends StatelessWidget {
  // Initial list of student requests
  final List<StudentRequest> studentRequests = [
    StudentRequest(
      name: 'Nora Omar',
      grade: 'Grade 11',
      time: 'Saturday | 3:15 AM',
      method: 'Chat',
      questionCount: 2,
      color: Colors.yellow.shade100,
    ),
    StudentRequest(
      name: 'Faisal Omar',
      grade: 'Grade 10',
      time: 'Saturday | 1:00 PM',
      method: 'Chat',
      questionCount: 1,
      color: Colors.orange.shade100,
    ),
    StudentRequest(
      name: 'Ahmed Omar',
      grade: 'Grade 10',
      time: 'Sunday | 9:30 AM',
      method: 'Virtual',
      questionCount: 3,
      color: Colors.blue.shade100,
    ),
  ];

  // Additional requests to display on the "All Requests" page
  final List<StudentRequest> allRequests = [
    StudentRequest(
      name: 'Sara Ali',
      grade: 'Grade 12',
      time: 'Monday | 10:00 AM',
      method: 'Virtual',
      questionCount: 4,
      color: Colors.yellow.shade100,
    ),
    StudentRequest(
      name: 'Omar Khalid',
      grade: 'Grade 9',
      time: 'Tuesday | 12:30 PM',
      method: 'Chat',
      questionCount: 2,
      color: Colors.orange.shade100,
    ),
    StudentRequest(
      name: 'Layla Ahmed',
      grade: 'Grade 11',
      time: 'Wednesday | 4:15 PM',
      method: 'Virtual',
      questionCount: 5,
      color: Colors.blue.shade100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background with subtle circular bottom
          ClipPath(
            clipper: SubtleCurveClipper(),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.indigoAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Stack(
                  children: [
                    Positioned(
                      left: 15,
                      top: 20,
                      child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.black, size: 30),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Menu button pressed')),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage('assets/avatar.png'),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Welcome,',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Khalid Naif',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              // Student Requests Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Student's Requests",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz, color: Colors.black54),
                            onPressed: () {
                              // Navigate to the "All Requests" page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AllRequestsPage(requests: allRequests),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: studentRequests.length,
                          itemBuilder: (context, index) {
                            final request = studentRequests[index];
                            return StudentRequestCard(
                              request: request,
                              onArrowPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RequestDetailsPage(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// All Requests Page
class AllRequestsPage extends StatelessWidget {
  final List<StudentRequest> requests;

  const AllRequestsPage({required this.requests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Student Requests'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return StudentRequestCard(
                    request: request,
                    onArrowPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcceptRejectPage(request: request),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Accept/Reject Page
class AcceptRejectPage extends StatelessWidget {
  final StudentRequest request;

  const AcceptRejectPage({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accept/Reject Request'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Request from ${request.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Grade: ${request.grade}'),
            Text('Time: ${request.time}'),
            Text('${request.questionCount} Questions'),
            Text('Method: ${request.method}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Accept
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Reject
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for Subtle Circular Bottom
class SubtleCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Data Model for Student Request
class StudentRequest {
  final String name;
  final String grade;
  final String time;
  final String method;
  final int questionCount;
  final Color color;

  StudentRequest({
    required this.name,
    required this.grade,
    required this.time,
    required this.method,
    required this.questionCount,
    required this.color,
  });
}

// Student Request Card Widget
class StudentRequestCard extends StatelessWidget {
  final StudentRequest request;
  final VoidCallback onArrowPressed;

  const StudentRequestCard({
    required this.request,
    required this.onArrowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: request.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    request.grade,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    request.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: onArrowPressed,
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.question_answer, size: 16, color: Colors.black54),
                    SizedBox(width: 5),
                    Text(
                      '${request.questionCount} Questions',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Icon(
                      request.method == 'Chat' ? Icons.chat : Icons.videocam,
                      size: 16,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 5),
                    Text(
                      request.method,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}