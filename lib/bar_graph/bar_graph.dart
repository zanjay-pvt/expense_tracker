import 'package:expense_tracker/bar_graph/bar_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tuesAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: myBarData.barDatas
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[800],
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
