import 'package:expense_tracker/bar_graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

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
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          sunAmount: value.CalculateDailyExpenseSummary()[sunday] ?? 0,
          monAmount: value.CalculateDailyExpenseSummary()[monday] ?? 0,
          tuesAmount: value.CalculateDailyExpenseSummary()[tuesday] ?? 0,
          wedAmount: value.CalculateDailyExpenseSummary()[wednesday] ?? 0,
          thurAmount: value.CalculateDailyExpenseSummary()[thursday] ?? 0,
          friAmount: value.CalculateDailyExpenseSummary()[friday] ?? 0,
          satAmount: value.CalculateDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
