// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class ConfidenceBarChart extends StatefulWidget {
//   final Map<String, double> topResults;

//   const ConfidenceBarChart({super.key, required this.topResults});

//   @override
//   State<ConfidenceBarChart> createState() => _ConfidenceBarChartState();
// }

// class _ConfidenceBarChartState extends State<ConfidenceBarChart>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );

//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = [
//       Colors.green,
//       Colors.blue,
//       Colors.orange,
//       Colors.purple,
//       Colors.red,
//     ];
//     final entries = widget.topResults.entries.toList();

//     return AspectRatio(
//       aspectRatio: 1.4,
//       child: AnimatedBuilder(
//         animation: _animation,
//         builder: (context, child) {
//           final barGroups = entries.asMap().entries.map((entry) {
//             final index = entry.key;
//             final data = entry.value;

//             return BarChartGroupData(
//               x: index,
//               barRods: [
//                 BarChartRodData(
//                   toY: data.value * _animation.value,
//                   width: 26,
//                   color: colors[index % colors.length],
//                   borderRadius: BorderRadius.circular(6),
//                   backDrawRodData: BackgroundBarChartRodData(
//                     show: true,
//                     toY: 100,
//                     color: Colors.grey.shade300,
//                   ),
//                 ),
//               ],
//             );
//           }).toList();

//           return BarChart(
//             BarChartData(
//               maxY: 100,
//               minY: 0,
//               barGroups: barGroups,
//               gridData: FlGridData(
//                 show: true,
//                 drawVerticalLine: false,
//                 horizontalInterval: 20,
//                 getDrawingHorizontalLine: (value) => FlLine(
//                   color: Colors.grey.shade300,
//                   strokeWidth: 1,
//                 ),
//               ),
//               titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 60,
//                     getTitlesWidget: (value, meta) {
//                       final index = value.toInt();
//                       if (index < 0 || index >= entries.length) {
//                         return const SizedBox();
//                       }
//                       final label = entries[index].key;
//                       final confidence = entries[index].value.toStringAsFixed(1);
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         space: 8,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               '$confidence%',
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               label,
//                               style: const TextStyle(fontSize: 11),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 20,
//                     getTitlesWidget: (value, meta) => SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       space: 6,
//                       child: Text(
//                         '${value.toInt()}',
//                         style: const TextStyle(fontSize: 10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 rightTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 topTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//               ),
//               borderData: FlBorderData(show: false),
//               barTouchData: BarTouchData(
//                 enabled: true,
//                 handleBuiltInTouches: true,
//                 touchTooltipData: BarTouchTooltipData(
//                   tooltipBgColor: Colors.black87,
//                   tooltipPadding: const EdgeInsets.all(8),
//                   tooltipMargin: 8,
//                   getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                     final label = entries[group.x.toInt()].key;
//                     final value = (rod.toY).toStringAsFixed(1);
//                     return BarTooltipItem(
//                       '$label\n$value%',
//                       const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ConfidenceBarChart extends StatefulWidget {
  final Map<String, double> topResults;

  const ConfidenceBarChart({super.key, required this.topResults});

  @override
  State<ConfidenceBarChart> createState() => _ConfidenceBarChartState();
}

class _ConfidenceBarChartState extends State<ConfidenceBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Color _getBarColor(String label) {
    final lower = label.toLowerCase();
    if (lower.contains("healthy")) return Colors.green;
    if (lower.contains("gall")) return Colors.red;
    if (lower.contains("sooty") || lower.contains("mould")) return Colors.orange;
    return Colors.blueGrey; // default
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = widget.topResults.entries.toList();

    return AspectRatio(
      aspectRatio: 1.4,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final barGroups = entries.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.value * _animation.value,
                  width: 26,
                  color: _getBarColor(data.key),
                  borderRadius: BorderRadius.circular(6),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 100,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            );
          }).toList();

          return BarChart(
            BarChartData(
              maxY: 100,
              minY: 0,
              barGroups: barGroups,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 20,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= entries.length) {
                        return const SizedBox();
                      }
                      final label = entries[index].key;
                      final confidence = entries[index].value.toStringAsFixed(1);
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$confidence%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              label,
                              style: const TextStyle(fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 6,
                      child: Text(
                        '${value.toInt()}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black87,
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final label = entries[group.x.toInt()].key;
                    final value = (rod.toY).toStringAsFixed(1);
                    return BarTooltipItem(
                      '$label\n$value%',
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
