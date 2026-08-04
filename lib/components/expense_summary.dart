import 'package:expense_tracker/bar_graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;
    List<double> values = [
      value.CalculateDailyExpenseSummary()[sunday] ?? 0,
      value.CalculateDailyExpenseSummary()[monday] ?? 0,
      value.CalculateDailyExpenseSummary()[tuesday] ?? 0,
      value.CalculateDailyExpenseSummary()[wednesday] ?? 0,
      value.CalculateDailyExpenseSummary()[thursday] ?? 0,
      value.CalculateDailyExpenseSummary()[friday] ?? 0,
      value.CalculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 5000 : max;
  }

  String CalculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.CalculateDailyExpenseSummary()[sunday] ?? 0,
      value.CalculateDailyExpenseSummary()[monday] ?? 0,
      value.CalculateDailyExpenseSummary()[tuesday] ?? 0,
      value.CalculateDailyExpenseSummary()[wednesday] ?? 0,
      value.CalculateDailyExpenseSummary()[thursday] ?? 0,
      value.CalculateDailyExpenseSummary()[friday] ?? 0,
      value.CalculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday = ConvertDateTime(startOfWeek.add(Duration(days: 0)));
    String monday = ConvertDateTime(startOfWeek.add(Duration(days: 1)));
    String tuesday = ConvertDateTime(startOfWeek.add(Duration(days: 2)));
    String wednesday = ConvertDateTime(startOfWeek.add(Duration(days: 3)));
    String thursday = ConvertDateTime(startOfWeek.add(Duration(days: 4)));
    String friday = ConvertDateTime(startOfWeek.add(Duration(days: 5)));
    String saturday = ConvertDateTime(startOfWeek.add(Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Row(
              children: [
                const Text(
                  'Week Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\₹${CalculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(
                value,
                sunday,
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
              ),
              sunAmount: value.CalculateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.CalculateDailyExpenseSummary()[monday] ?? 0,
              tuesAmount: value.CalculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.CalculateDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.CalculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.CalculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.CalculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
