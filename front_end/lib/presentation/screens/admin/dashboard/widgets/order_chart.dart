import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constants/sizes.dart';

class OrdersChart extends StatelessWidget {
  final Map<DateTime, int> ordersPerDay;

  const OrdersChart({super.key, required this.ordersPerDay});

  @override
  Widget build(BuildContext context) {
    final sortedDates = ordersPerDay.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Số đơn hàng 7 ngày qua', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: AppSizes.spaceBtwItems),
        AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              minY: 0,
              maxY: (ordersPerDay.values.reduce((a, b) => a > b ? a : b)).toDouble() + 1,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < sortedDates.length) {
                        final date = sortedDates[value.toInt()];
                        return Text('${date.day}/${date.month}', style: const TextStyle(fontSize: 10));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, interval: 1),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: true),
              barGroups: sortedDates.asMap().entries.map((entry) {
                final index = entry.key;
                final date = entry.value;
                final orders = ordersPerDay[date] ?? 0;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: orders.toDouble(),
                      color: Colors.deepPurple,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
