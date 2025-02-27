import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/AR_dashboard.dart';
import 'package:gat_helper_app/features/auth/views/All_req_page.dart';
import 'package:gat_helper_app/features/auth/views/GG_waiting.dart';
import 'package:gat_helper_app/features/auth/views/Group_GameQ.dart';
import 'package:gat_helper_app/features/auth/views/find_game_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';

import '../../common/edit_profile_page.dart';

import 'package:gat_helper_app/features/auth/views/DashBoard.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => StudentHome();
}


class StudentHome extends State<StudentHomePage> {
  String status1 = 'Waiting';
  String status2 = 'Waiting';

  List<Map<String, String>> parents = [
    {
      "name": "Omar Saad",
      "email": "omar123@gmail.com",
      "status": "Waiting",
      "gender": "male"
    },
    {
      "name": "Sara Omer",
      "email": "omar123@gmail.com",
      "status": "Waiting",
      "gender": "female"
    } // list from database
  ];


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 500,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF284379),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/student.png"),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Huda Omer",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                      builder: (context) => EditProfilePage(role: 'student', initialData: {}),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.messenger_outline, color: Colors.black),
                title: const Text('Requests'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestsPage(),
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
          Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            "assets/blue_background.png",
            fit: BoxFit.cover,
            height: 380,
            width: screenWidth,
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
            Positioned(
              top: 10,
              right: 5,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/student.png"),
              ),
            ),






        Column(
            children: [
            _buildProfileHeader(),
              Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      const Text(
                        "Select Your Game",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8), // Spacing between text and images
                      // Row with two images next to each other
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GroupGamePageWidget()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Ink.image(
                                image: AssetImage('assets/group_game.png'),
                                height: 210,
                                width: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                                onTap: () {
                                  builder: (context) => LeaderWidget();
                                },
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(90), // تغيير الرقم لضبط مقدار الانحناء
                              child: Ink.image(
                                image: AssetImage('assets/self_game.png'),
                                height: 210,
                                width: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [const Text(
                          "My Parents",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                                        ]
                      ),
                    ),
                      Row(

                        children: parents
                            .map((parent) => _buildParentCard(
                          parent["name"]!,
                          parent["email"]!,
                          parent["status"]!,
                          parent["gender"]!, // ✅ أضفنا `gender` هنا
                              (newStatus) {
                            setState(() {
                              if (newStatus == "Rejected") {
                                parents.removeWhere((p) => p["name"] == parent["name"]);
                              } else {
                                parent["status"] = newStatus;
                              }
                            });
                          },
                        ))

                            .toList(),
                      ),

                    ],
                  ),
                ),
              ),
            ),

        ]
        ),
          ],
        ),
    );

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

  Widget _buildProfileHeader() {

    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [



    Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Progress",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()), // استبدل `NewPage` بصفحتك
                      );
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child:_profileDashboard(),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _profileDashboard() {
    return Center(
      child: Container(
        width: 350,  // زيادة العرض
        height: 170, // زيادة الارتفاع لاستيعاب التاريخ
        decoration: BoxDecoration(
          color: Colors.orange.shade200,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // موضع الظل
            ),
          ],
        ),
        child: Stack(
          children: [
            // ✅ الفترة الزمنية التاريخية (أعلى الصندوق)
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                "January - June 2024",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // ✅ إضافة محتوى الصندوق مع "Quiz Passed"
            Positioned(
              top: 40, // تحريك المحتوى لأسفل بعد التاريخ
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, color: Colors.white, size: 40),
                      SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: '27 min \n',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Usage time',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8), // مسافة بين النصوص
                  Row(
                    children: [
                      Icon(Icons.check_box_rounded, color: Colors.white, size: 40),
                      SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: '200 \n',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Correct answers',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ "Quiz Passed" مع الدائرة البيانية على اليمين
            Positioned(
              top: 20, // ✅ ضبط موقع الدائرة داخل البطاقة
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Quiz Passed",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8), // مسافة بين العنوان والدائرة
                  Container(
                    width: 80, // ✅ زيادة الحجم
                    height: 80, // ✅ زيادة الحجم
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // ✅ الدائرة الخلفية الرمادية
                        SizedBox(
                          width: 90, // ✅ تكبير الدائرة الخلفية
                          height: 90,
                          child: CircularProgressIndicator(
                            value: 1, // تمثل 100% لتكون دائرة كاملة
                            strokeWidth: 12, // ✅ ضبط السماكة
                            backgroundColor: Colors.white30,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
                          ),
                        ),
                        // ✅ الدائرة الزرقاء الأمامية (75%)
                        SizedBox(
                          width: 80, // ✅ تكبير الدائرة الأمامية بنفس الحجم
                          height: 80,
                          child: CircularProgressIndicator(
                            value: 0.75, // ✅ تمثل 75% من الدائرة
                            strokeWidth: 14, // ✅ ضبط السماكة
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          ),
                        ),
                        // ✅ النص في وسط الدائرة
                        Center(
                          child: Text(
                            "23 Wins\n(75%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12, // ✅ زيادة حجم الخط
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
      ),
    );
  }

  Widget build1(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // ✅ جعل العرض غير محدد
          child: SingleChildScrollView( // ✅ في حال كانت العناصر كثيرة
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: parents
                  .map((parent) => _buildParentCard(
                parent["name"]!,
                parent["email"]!,
                parent["status"]!,
                parent["gender"]!,
                    (newStatus) {
                  setState(() {
                    if (newStatus == "Rejected") {
                      parents.removeWhere((p) => p["name"] == parent["name"]);
                    } else {
                      parent["status"] = newStatus;
                    }
                  });
                },
              ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }





  Widget _buildParentCard(
      String name, String email, String status, String gender, Function(String) onStatusChanged) {
    return Container(
      margin: EdgeInsets.only(top: 6, left: 10),
      width: 170,
      height: 120,

      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ✅ صورة الأفتار (تتغير حسب الجنس)
          Positioned(
            top: 10,
            left: 8,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white70,
              backgroundImage: AssetImage(
                gender == "male" ? "assets/parent1.png" : "assets/parent2.png",
              ),
            ),
          ),

          if (status.isNotEmpty)
            Positioned(
              top: 8,
              right: 8,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: status == 'Approved' ? 1.0 : 1.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'Approved' ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (status == 'Waiting')
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check_outlined, color: Colors.green),
                    onPressed: () {

                      onStatusChanged('Approved');

                      Future.delayed(Duration(seconds: 2), () {
                        onStatusChanged('');
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close_outlined, color: Colors.red),
                    onPressed: () {
                      onStatusChanged('Rejected');
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

}

