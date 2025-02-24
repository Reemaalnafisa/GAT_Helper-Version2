

import 'dart:ui';

import 'package:gat_helper_app/model/BarGraphModel.dart';

class BarGraphData {
  final data = [
    const BarGraphModel(
        label: "Active Hours",
        color: Color(0xFF5A88FE),
        graph: [
          GraphModel(x: 0, y: 2),  // Monday
          GraphModel(x: 1, y: 4),  // Tuesday
          GraphModel(x: 2, y: 6),  // Wednesday
          GraphModel(x: 3, y: 10), // Thursday
          GraphModel(x: 4, y: 12), // Friday
          GraphModel(x: 5, y: 8),  // Saturday
          GraphModel(x: 6, y: 14), // Sunday
        ]),
  ];

  final label = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
}
