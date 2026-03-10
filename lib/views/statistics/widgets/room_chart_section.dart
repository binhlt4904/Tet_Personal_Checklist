import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';

class RoomChartSection extends StatelessWidget {
  final List<Task> tasks;

  const RoomChartSection({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final rooms = [
      'Phòng khách',
      'Phòng ngủ',
      'Nhà bếp',
      'Nhà vệ sinh',
      'Ban công',
      'Phòng thờ'
    ];

    List<BarChartGroupData> groups = [];
    double maxRoomTask = 0;

    for (int i = 0; i < rooms.length; i++) {
      final roomTasks =
      tasks.where((t) => t.room == rooms[i]).toList();

      final total = roomTasks.length.toDouble();
      final done =
      roomTasks.where((t) => t.isDone).length.toDouble();

      if (total > maxRoomTask) {
        maxRoomTask = total;
      }

      groups.add(
        BarChartGroupData(
          x: i,
          barsSpace: 6,
          barRods: [
            BarChartRodData(
              toY: total,
              color: Colors.red.shade300,
              width: 12,
              borderRadius: BorderRadius.circular(4),
            ),
            BarChartRodData(
              toY: done,
              color: Colors.green,
              width: 12,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

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
              "📊 Tiến độ theo phòng",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// Legend
            Row(
              children: [
                _legendItem(Colors.red.shade300, "Tổng task"),
                const SizedBox(width: 16),
                _legendItem(Colors.green, "Đã hoàn thành"),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: rooms.length * 80, // mỗi phòng chiếm 80px
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxRoomTask + 1,
                      barGroups: groups,
                      gridData: FlGridData(
                        show: true,
                        horizontalInterval: 1,
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 30,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              return Transform.rotate(
                                angle: -0.5, // xoay chữ cho đỡ dính
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    rooms[value.toInt()],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}