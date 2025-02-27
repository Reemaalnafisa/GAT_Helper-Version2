import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/const/data/line_chart_data.dart';
import 'package:gat_helper_app/features/auth/views/BarGraphCard.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final LineData data = LineData();
  int selectedMonthIndex = 0;

  void nextMonth() {
    setState(() {
      if (selectedMonthIndex < data.months.length - 1) {
        selectedMonthIndex++;
      }
    });
  }

  void previousMonth() {
    setState(() {
      if (selectedMonthIndex > 0) {
        selectedMonthIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedMonth = data.months[selectedMonthIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      DashboardHeader(),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          LastGameWidget(),
                          SizedBox(width: 15),
                          QuizPassedWidget(),
                        ],
                      ),
                      BarGraphCard(),
                      LineChartCard(
                        selectedMonth: selectedMonth,
                        onNextMonth: nextMonth,
                        onPreviousMonth: previousMonth,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// ✅ أضف `DashboardBottom` هنا
          DashboardBottom( screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,)
        ],
      ),
    );




  }
}






class LineChartCard extends StatelessWidget {
  final String selectedMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onPreviousMonth;

  const LineChartCard({
    required this.selectedMonth,
    required this.onNextMonth,
    required this.onPreviousMonth,
  });

  @override
  Widget build(BuildContext context) {
    final data = LineData();

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onPreviousMonth,
                    child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: 5),
                  Text(
                    selectedMonth,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: onNextMonth,
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Verbal", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Quantitative", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          // تحديد حجم العرض ليشغل نصف الشاشة
          AspectRatio(
            aspectRatio: 8 / 2.5,
            child: Container(
              height: MediaQuery.of(context).size.height / 1, // نصف الشاشة
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(handleBuiltInTouches: true),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (data.bottomTitle.containsKey(value.toInt())) {
                            return Padding(
                              padding: EdgeInsets.only(top: 2.5),
                              child: Text(
                                data.bottomTitle[value.toInt()]!,
                                style: TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      color: Colors.white,
                      barWidth: 2,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: false),
                      spots: data.spots1[selectedMonth] ?? [],
                    ),
                    LineChartBarData(
                      color: Colors.orange,
                      barWidth: 2,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: false),
                      spots: data.spots2[selectedMonth] ?? [],
                    ),
                  ],
                  minX: 1,
                  maxX: 50,
                  minY: 0,
                  maxY: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/rectangle1.png',
          width: double.infinity,
          height: 150, // ✅ تقليل الارتفاع
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 33, // ✅ تحريك الأيقونة للأعلى قليلاً
          right: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentHomePage()),
              );
            },
          ),
        ),
        Positioned(
          top: 88, // ✅ تحريك النص للأعلى قليلاً
          left: 28,
          child: Text(
            'DashBoard',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 25, // ✅ تصغير حجم الخط
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}


/// ✅ **Widget: Quiz Passed Progress Indicator**
class QuizPassedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // عرض مماثل للـ Last Game
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), // الزوايا المستديرة مثل Last Game
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            "Quiz Passed",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12), // زيادة المسافة بين العنوان وبقية المحتوى


          Container(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // الدائرة الخلفية
                SizedBox(
                  width: 75,
                  height: 75,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 12,
                    backgroundColor: Colors.white30,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
                  ),
                ),
                // الدائرة الأمامية (تُظهر التقدم)
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: 0.75, // تغيير النسبة بناءً على البيانات
                    strokeWidth: 14,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ),
                // النص داخل الدائرة
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "23 Wins",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "(75%)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
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



/// ✅ **Widget: Performance Graph**
class PerformanceGraphWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 140,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "January",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Verbal", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Quantitativ",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/// ✅ **Widget: Last Game Section**
class LastGameWidget extends StatefulWidget {
  @override
  _LastGameWidgetState createState() => _LastGameWidgetState();
}

class _LastGameWidgetState extends State<LastGameWidget> {
  bool isGroupSelected = false; // متغير للتحكم في إظهار البيانات الإضافية

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
          Text(
            "Last Game",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),

          // زر الاختيار بين Self و Group
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGroupSelected = false; // عند اختيار Self، يتم إخفاء Rank
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: !isGroupSelected ? Colors.cyan.shade100 : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal, width: 1),
                  ),
                  child: Text(
                    "Self",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGroupSelected = true; // عند اختيار Group، يتم عرض البيانات فقط
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isGroupSelected ? Colors.orange.shade100 : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange, width: 1),
                  ),
                  child: Text(
                    "Group",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // عرض البيانات الأساسية
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Score", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("20/20", style: TextStyle(fontSize: 14)),
                  Text("21/11/2024", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardBottom extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const DashboardBottom({required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -screenHeight * 0.12,  // رفع الصورة قليلاً عن أسفل الشاشة
          left: -screenWidth * 0.02,  // ضبط المسافة من اليسار
          right: -screenWidth * 0.03,  // تعيين اليمين لتكون الصورة عند اليمين تمامًا
          child: Image.asset(
            'assets/YellowNew.png',
            fit: BoxFit.cover,  // ملاءمة الصورة بشكل مناسب
            width: screenWidth * 1.1,  // جعل العرض يتناسب مع حجم الشاشة
            height: screenHeight * 0.2,  // تعديل الارتفاع ليتناسب مع المساحة
          ),
        ),


        Positioned(
          bottom: -screenHeight * 0.13,  // رفع الصورة قليلاً عن أسفل الشاشة
          left: -screenWidth * 0.05,  // ضبط المسافة من اليسار
          right: -screenWidth * 0.05,  // ضبط المسافة من اليمين
          child: Image.asset(
            'assets/BlueNew.png',
            fit: BoxFit.cover,  // ملاءمة الصورة بشكل مناسب
            width: screenWidth * 1.1,  // جعل العرض يتناسب مع حجم الشاشة
            height: screenHeight * 0.2,  // تعديل الارتفاع ليتناسب مع المساحة
          ),
        ),


        // Math Image

      ],
    );
  }
}