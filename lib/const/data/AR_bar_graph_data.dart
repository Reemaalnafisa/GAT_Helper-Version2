import 'dart:ui';

import 'package:gat_helper_app/model/BarGraphModel.dart';

class BarGraphData {
  final data = [
    const BarGraphModel(
        label: "ساعات النشاط",  // تغيير التسمية إلى العربية
        color: Color(0xFF5A88FE),
        graph: [
          GraphModel(x: 0, y: 2),  // الأحد
          GraphModel(x: 1, y: 4),  // الإثنين
          GraphModel(x: 2, y: 6),  // الثلاثاء
          GraphModel(x: 3, y: 10), // الأربعاء
          GraphModel(x: 4, y: 12), // الخميس
          GraphModel(x: 5, y: 8),  // الجمعة
          GraphModel(x: 6, y: 14), // السبت
        ]),
  ];

  final label = ['أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت'];  // ترتيب الأيام من الأحد واستخدام الاختصارات
}
