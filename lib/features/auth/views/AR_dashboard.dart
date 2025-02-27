import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/const/data/AR_bar_graph_data.dart';
import 'package:gat_helper_app/const/data/AR_line_chart_data.dart';
import 'package:gat_helper_app/features/auth/views/Parent_home_pageAR.dart';
import 'package:gat_helper_app/model/BarGraphModel.dart';

class ARDashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<ARDashboard> {
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

/// Header of the Dashboard
class DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/AR_rectangle.png',
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 33,
          right: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParentHomePageAR()),
              );
            },
          ),
        ),
        Positioned(
          top: 88,
          right: 28,
          child: Text(
            'لوحة القيادة', // تغيير العنوان إلى العربية
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

/// Line Chart with Month Navigation
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
                    child: Text("شفهي", style: TextStyle(color: Colors.white)), // تغيير النص إلى العربي
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("كمي", style: TextStyle(color: Colors.white)), // تغيير النص إلى العربي
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 5,
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
                            padding: EdgeInsets.only(top: 5),
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
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                    dotData: FlDotData(show: false),
                    spots: data.spots1[selectedMonth] ?? [],
                  ),
                  LineChartBarData(
                    color: Colors.orange,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                    dotData: FlDotData(show: false),
                    spots: data.spots2[selectedMonth] ?? [],
                  ),
                ],
                minX: 1,
                maxX: 100,
                minY: 0,
                maxY: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// ✅ **Widget: قسم اللعبة الأخيرة**
/// ✅ **قسم اللعبة الأخيرة**
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // العنوان
          Text(
            "اللعبة الأخيرة",
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
                    "فردي",
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
                    "مجموعةٍ",
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
                  Text("20/20", style: TextStyle(fontSize: 14)),
                  Text("21/11/2024", style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("النقاط", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("التاريخ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ✅ **قسم ساعات النشاط**
class BarGraphCard extends StatelessWidget {
  const BarGraphCard({super.key});

  @override
  Widget build(BuildContext context) {
    final barGraphData = BarGraphData();
    debugPrint('BarGraph Data: ${barGraphData.data}'); // طباعة البيانات في الـ console

    return GridView.builder(
      itemCount: barGraphData.data.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,  // استخدام عمود واحد لعرض الرسم البياني
        crossAxisSpacing: 5,
        mainAxisSpacing: 6.0,
        childAspectRatio: 2 / 1,  // جعل الرسم البياني أكثر طولًا
      ),
      itemBuilder: (context, index) {
        return Container(
          width: 150, // تصغير العرض
          height: 100, // تصغير الارتفاع
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white, // خلفية بيضاء
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2), // تأثير الظل
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // تقليل padding لتوفير المساحة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    barGraphData.data[index].label,
                    style: const TextStyle(
                      fontSize: 18,  // تقليل حجم النص
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 8), // تقليل المسافة بين العناصر
                Flexible(
                  child: BarChart(
                    BarChartData(
                      barGroups: _chartGroups(
                        points: barGraphData.data[index].graph,
                        color: barGraphData.data[index].color,
                      ),
                      borderData: FlBorderData(border: const Border()),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  barGraphData.label[value.toInt()],
                                  style: const TextStyle(
                                      fontSize: 10, // تقليل حجم النص
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _chartGroups(
      {required List<GraphModel> points, required Color color}) {
    return points
        .map((point) => BarChartGroupData(x: point.x.toInt(), barRods: [
      BarChartRodData(
        toY: point.y,
        width: 9,  // تقليل عرض الأشرطة
        color: _getBarColor(point.y),  // استخدام ألوان ديناميكية للأشرطة
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
        ),
      )
    ]))
        .toList();
  }

  Color _getBarColor(double value) {
    if (value < 3) {
      return Colors.red.withOpacity(0.6);  // لون أحمر عندما تكون القيمة منخفضة
    } else if (value < 6) {
      return Colors.yellow.withOpacity(0.7);  // لون أصفر للقيم المتوسطة
    } else {
      return Colors.green.withOpacity(0.8);  // لون أخضر للقيم المرتفعة
    }
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
// ✅ **Widget: Quiz Passed Progress Indicator**
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
            "اختبار ناجح",
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
                      "فوز23 ",
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