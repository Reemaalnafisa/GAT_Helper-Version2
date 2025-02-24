import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/const/data/AR_bar_graph_data.dart';
import 'package:gat_helper_app/const/data/AR_line_chart_data.dart';
import 'package:gat_helper_app/features/auth/views/Parent_home_pageAR.dart';
import 'package:gat_helper_app/features/auth/views/student.dart';
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DashboardHeader(),
                  SizedBox(height: 0),
                  BarGraphCard(),
                  SizedBox(height: 1),
                  LineChartCard(
                    selectedMonth: selectedMonth,
                    onNextMonth: nextMonth,
                    onPreviousMonth: previousMonth,
                  ),
                  LastGameWidget(),
                ],
              ),
            ),
          ),
          /// الخلفية السفلية
          Image.asset(
            'assets/BB.png',
            width: double.infinity,
            height: 40,
            fit: BoxFit.cover,
          ),
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
      width: 400,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// ✅ **العنوان**
          Text(
            "اللعبة الأخيرة",  // تغيير النص إلى العربي
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),

          /// ✅ **زر الاختيار بين "نفسي" و "مجموعة"**
          Row(
            mainAxisAlignment: MainAxisAlignment.end,  // محاذاة العناصر من اليمين لليسار
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGroupSelected = false; // عند اختيار "نفسي"، يتم إخفاء الـ "رتبة"
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
                    "فردي",  // التسمية بالعربية
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
                    isGroupSelected = true; // عند اختيار "مجموعة"، يتم عرض الـ "رتبة"
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
                    "مجموعة",  // التسمية بالعربية
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

          /// ✅ **عرض البيانات الأساسية**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("20/20", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("21/11/2024", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("النتيجة", style: TextStyle(fontSize: 14)),
                  Text("التاريخ", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),

          /// ✅ **إضافة الرتبة عند اختيار "مجموعة"**
          if (isGroupSelected) ...[
            SizedBox(height: 10),
            Divider(color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("#2", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("الترتيب", style: TextStyle(fontSize: 14, color: Colors.blue)),
              ],
            ),
          ],
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
