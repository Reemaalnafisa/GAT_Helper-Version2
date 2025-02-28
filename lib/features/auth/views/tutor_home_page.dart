import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/Student_chat_page.dart';
import 'package:gat_helper_app/features/auth/views/request_link_page.dart';
import 'package:gat_helper_app/features/auth/views/tutor_request_details_page.dart';
import 'package:gat_helper_app/features/common/edit_profile_page.dart';
import 'package:gat_helper_app/features/auth/views/tutor_chat_history_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';

class TutorHomepage extends StatefulWidget {
  @override
  _TutorHomepageState createState() => _TutorHomepageState();
}

class _TutorHomepageState extends State<TutorHomepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<StudentRequest> studentRequests = [
    StudentRequest(
      name: 'Nora Omar',
      grade: 'Grade 11',
      time: 'Saturday | 3:15 AM',
      method: 'Chat',
      questionCount: 2,
      color: Colors.yellow.shade100,
      question: "The Pin number of a phone is formed from four numbers (from 0 to 9). How many ways can it be formed?",
      options: ["10000", "6500", "5040", "4000"],
    ),
    StudentRequest(
      name: 'Faisal Omar',
      grade: 'Grade 10',
      time: 'Saturday | 1:00 PM',
      method: 'Virtual',
      questionCount: 1,
      color: Colors.orange.shade100,
      question: "FALLING: GRAVITATION",
      options: [
        "collapse : destruction",
        "balloon : sky",
        "pressure : air",
        "electricity : lamp",
      ],
    ),
    StudentRequest(
      name: 'Sara Ali',
      grade: 'Grade 12',
      time: 'Sunday | 10:30 AM',
      method: 'Chat',
      questionCount: 3,
      color: Colors.green.shade100,
      question: "A car travels at a speed of 50 km/h. How long will it take to travel 200 km?",
      options: ["2 hours", "4 hours", "5 hours", "3 hours"],
    ),
    StudentRequest(
      name: 'Ahmed Saleh',
      grade: 'Grade 9',
      time: 'Monday | 8:00 AM',
      method: 'Virtual',
      questionCount: 2,
      color: Colors.blue.shade100,
      question: "What is the capital of France?",
      options: ["Berlin", "Madrid", "Paris", "Rome"],
    ),
  ];String TutorName = "Khalid Naif"; // Replace with dynamic data
  String TutorEmail = "Khalid.naif@example.com"; // Replace with dynamic data
  String TutorAvatar = "assets/img_20.png"; // Replace

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: 500,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF284379),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(TutorAvatar), // Dynamic Avatar
                    ),
                    const SizedBox(height: 10),
                    Text(
                      TutorName, // Dynamic Name
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      TutorEmail, // Dynamic Email
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.black),
              title: const Text('Edit your profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfilePage(role: 'tutor', initialData: {}),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatHistoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.black),
              title: const Text('Contact Us'),
              onTap: () {
                _showContactUsDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Blue background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/img_23.png",
              fit: BoxFit.cover,
              height: 380,
              width: screenWidth,
            ),
          ),
          // Menu icon
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.black, size: 30),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          // Profile header
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Color(0xFF284379),                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome,',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
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
          // Body content
          Positioned.fill(
            top: 380,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Student's Requests",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllRequestsPage(requests: studentRequests)));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // ListView for displaying requests one under the other
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: studentRequests.length,
                    itemBuilder: (context, index) {
                      final request = studentRequests[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestDetailsPage(
                                request: request,
                                onReject: () {
                                  setState(() {
                                    studentRequests.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                },
                                onAccept: () {
                                  if (request.method == 'Chat') {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage()));
                                  } else if (request.method == 'Virtual') {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => SessionLinkPage()));
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: request.color,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Name (Always on Left)
                                        Text(
                                          request.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Grade (Below Name, Still Left-Aligned)
                                        Text(
                                          request.grade,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Question Count & Chat Method Row
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.question_answer, size: 16),
                                                const SizedBox(width: 4),
                                                Text("${request.questionCount}"),
                                              ],
                                            ),
                                            const SizedBox(width: 16),
                                            Row(
                                              children: [
                                                const Icon(Icons.chat, size: 16),
                                                const SizedBox(width: 4),
                                                Text(request.method),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // ✅ Fix: Date/Time moved to Right (Properly)
                                    Positioned(
                                      top: 0, // Ensures it's at the top
                                      right: 0, // ✅ Now it stays on the right dynamically
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min, // Keeps it compact
                                        children: [
                                          Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                                          const SizedBox(width: 4),
                                          Text(
                                            request.time,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
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
}


void _showContactUsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Get in touch with us", textAlign: TextAlign.center),
        content: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "If you have any questions, feel free to contact us at:\n\n",
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: "GAThelper@gmail.com\n\n",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const TextSpan(
                text: "We're here to assist you!",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class RequestDetailsPage extends StatelessWidget {
  final StudentRequest request;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const RequestDetailsPage({
    required this.request,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/img_17.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 120,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Request Details",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.help_outline, color: Colors.black54),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            request.question,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: request.options
                          .map((option) => _buildOption(option))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: Size(140, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Reject',
                    style: TextStyle(
                      color: Colors.white, // ✅ Fixed style syntax
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: Size(140, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      color: Colors.white, // ✅ Fixed style syntax
                    ),
                  ),

                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
    );
  }

  Widget _buildOption(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.radio_button_off, color: Colors.black54, size: 20),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}


class AllRequestsPage extends StatefulWidget {
  final List<StudentRequest> requests;

  const AllRequestsPage({Key? key, required this.requests}) : super(key: key);

  @override
  _AllRequestsPageState createState() => _AllRequestsPageState();
}

class _AllRequestsPageState extends State<AllRequestsPage> {
  late List<StudentRequest> requests;

  @override
  void initState() {
    super.initState();
    requests = List.from(widget.requests); // ✅ Copy initial requests list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Requests",
          style: TextStyle(
            color: Colors.white, // ✅ Ensures the text color is white
          ),
        ),
        flexibleSpace: Image.asset(
          "assets/img_17.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: 120,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),// ✅ Keeps the background color
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestDetailsPage(
                    request: request,
                    onReject: () {
                      setState(() {
                        requests.removeAt(index); // ✅ Update list on rejection
                      });
                      Navigator.pop(context); // ✅ Close details page
                    },
                    onAccept: () {
                      if (request.method == 'Chat') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage()));
                      } else if (request.method == 'Virtual') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SessionLinkPage()));
                      }
                    },
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: request.color,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              request.grade,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.question_answer, size: 16),
                                    const SizedBox(width: 4),
                                    Text("${request.questionCount}"),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    const Icon(Icons.chat, size: 16),
                                    const SizedBox(width: 4),
                                    Text(request.method),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                // Timer in the upper right corner
                Positioned(
                  top: 25,
                  right: 45,
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        request.time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



class StudentRequest {
  final String name;
  final String grade;
  final String time;
  final String method;
  final int questionCount;
  final Color color;
  final String question;
  final List<String> options;

  StudentRequest({
    required this.name,
    required this.grade,
    required this.time,
    required this.method,
    required this.questionCount,
    required this.color,
    required this.question,
    required this.options,
  });
}