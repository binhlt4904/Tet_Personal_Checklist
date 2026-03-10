import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';

class ScheduleChartSection extends StatelessWidget {
  final List<Task> tasks;

  const ScheduleChartSection({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final dates = List.generate(
      5,
          (index) => today.subtract(Duration(days: 4 - index)),
    );

    List<FlSpot> spots = [];

    for (int i = 0; i < dates.length; i++) {
      final date = dates[i];

      final count = tasks.where((task) {
        return task.isDone &&
            task.deadline != null &&
            task.deadline!.year == date.year &&
            task.deadline!.month == date.month &&
            task.deadline!.day == date.day;
      }).length;

      spots.add(FlSpot(i.toDouble(), count.toDouble()));
    }

    final maxY =
    spots.map((e) => e.y).fold<double>(0, (a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📅 Lịch trình công việc (5 ngày gần nhất)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 300,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ===== TITLE Y =====
                        SizedBox(
                          width: 20,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "Số công việc hoàn thành",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // ===== CHART =====
                        Expanded(
                          child: LineChart(
                            LineChartData(
                              minY: 0,
                              maxY: maxY + 1,
                              gridData: FlGridData(show: true),
                              borderData: FlBorderData(show: true),

                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    reservedSize: 28,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index < 0 || index >= dates.length) {
                                        return const SizedBox();
                                      }

                                      final d = dates[index];
                                      return Text(
                                        "${d.day}/${d.month}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 11),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    reservedSize: 28,
                                    getTitlesWidget: (value, meta) {
                                      if (value % 1 != 0) {
                                        return const SizedBox();
                                      }
                                      return Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(fontSize: 11),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),

                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  preventCurveOverShooting: true,
                                  color: Colors.green,
                                  barWidth: 3,
                                  dotData: const FlDotData(show: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ===== TITLE X =====
                  const Center(
                    child: Text(
                      "Ngày",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}