import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/Group_GameQ.dart';
import 'dart:async';

import 'package:gat_helper_app/features/auth/views/QQ_Rank.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';

class LeaderWidget extends StatefulWidget {
  @override
  _LeaderWidgetState createState() => _LeaderWidgetState();
}

class _LeaderWidgetState extends State<LeaderWidget> {
  int remainingTime = 10* 60; // ✅ تحويل الوقت لـ 10 دقائق
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        showTimeOutPopup(); // ✅ عرض رسالة عند انتهاء الوقت
      }
    });
  }


  @override
  void dispose() {
    timer?.cancel();  // إيقاف التايمر عند مغادرة الصفحة
    super.dispose();
  }


  // 🚨 نافذة انتهاء الوقت
  void showTimeOutPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color.fromRGBO(214, 222, 151, 1.0),
          title: Text(
            "Time's Up!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            "Waiting time is over. You will be redirected to the Home Page.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // ✅ الرجوع للصفحة السابقة
              },
              child: Text("OK", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 🌅 الخلفية العامة
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [Color(0xC5DDF2FF)],
              ),
            ),
          ),

          // 🚪 زر الخروج
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.redAccent, size: 30),
              onPressed: showExitConfirmationDialog
            ),
          ),

          // ⏳ المؤقت الدائري (يظهر الوقت بالدقائق)
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 2.5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: remainingTime / (10 * 60),
                    strokeWidth: 5,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ),
                Text(
                  '${(remainingTime ~/ 60)}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // 📦 صندوق المعلومات الرئيسي
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.8,
                      colors: [Color(0xC5DDF2FF), Color(0xFF698AC8)],
                      stops: [0.1, 0.7],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Waiting...',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      _buildInfoRow('Type of Questions:', 'Quantitative'),
                      _buildInfoRow('Number of Questions:', '10'),
                      _buildInfoRow('Timer of Game:', '10 min'), // ✅ تغيير الوقت إلى دقائق
                      _buildInfoRow('Number of Participants:', '7/15'),
                      SizedBox(height: 10),
                      Text('Join code:', style: TextStyle(fontSize: 18, color: Colors.white)),
                      Text(
                        '322719',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🌊 الخلفية السفلية
          Positioned(
            bottom: screenHeight * 0,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Image.asset(
              fit: BoxFit.cover,
              'assets/downgreen_background.png',
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
          // Math Image
          Positioned(
            bottom: -screenHeight * 0.12,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Image.asset(
              'assets/BB.png',
              fit: BoxFit.cover,
              width: screenWidth * 1.2,
              height: screenHeight * 0.3,
            ),
          ),

          // 🟢 زر Start Game
          Positioned(
            bottom: screenHeight * 0.20,
            left: screenWidth / 2 - 75,
            child: ElevatedButton(
              onPressed: () {
                // إيقاف التايمر عند الضغط على الزر
                timer?.cancel();

                // الانتقال إلى صفحة GroupGamePageWidget بعد إيقاف التايمر
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupGamePageWidget()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(214, 222, 151, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Start Game', style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          )

        ],
      ),
    );
  }

  // 🔹 تصميم صفوف المعلومات
  Widget _buildInfoRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
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
                    timer?.cancel(); // إيقاف التايمر عند الخروج من الصفحة
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentHomePage(), // Navigate to StudentHomePage
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

}
