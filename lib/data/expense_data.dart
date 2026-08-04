import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:expense_tracker/data/hive_database.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // List of all expenses
  List<ExpenseItems> overallexpenseList = [];

  // Prepare database reference
  final db = HiveDatabase();

  // Load data from Hive database
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallexpenseList = db.readData();
    }
  }

  // Get expense list
  List<ExpenseItems> getAllExpenseList() {
    return overallexpenseList;
  }

  // Add expenses
  void AddExpenses(ExpenseItems newExpense) {
    overallexpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallexpenseList);
  }

  // Delete expenses
  void DeleteExpenses(ExpenseItems expense) {
    overallexpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallexpenseList);
  }

  //update expense
  void UpdateExpense(ExpenseItems oldExpense, ExpenseItems updatedExpense) {
    int index = overallexpenseList.indexOf(oldExpense);
    if (index != -1) {
      overallexpenseList[index] = updatedExpense;
      notifyListeners();
      db.saveData(overallexpenseList);
    }
  }

  // Get weekday (mon, tues, etc) from a datetime objective
  String GetDayName(DateTime dateTIme) {
    switch (dateTIme.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thurs";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  // Get the date for the start of the week (sunday)
  DateTime StartOfWeekDate() {
    DateTime? startOfWeek;

    // Get today date
    DateTime today = DateTime.now();

    // Go backward from today to find the sunday
    for (int i = 0; i < 7; i++) {
      if (GetDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  // Convert overall expenses in daily expenses summary
  Map<String, double> CalculateDailyExpenseSummary() {
    Map<String, double> DailyExpenseSummary = {
      // date(yyyymmdd) : amount of total
    };

    for (var expense in overallexpenseList) {
      String date = ConvertDateTime(expense.time);

      // Clean the amount string to safely parse and avoid format exceptions
      String cleanedAmount = expense.amount.replaceAll(RegExp(r'[^0-9.]'), '');
      double amount = double.tryParse(cleanedAmount) ?? 0.0;

      if (DailyExpenseSummary.containsKey(date)) {
        double currentAmount = DailyExpenseSummary[date]!;
        currentAmount += amount;
        DailyExpenseSummary[date] = currentAmount;
      } else {
        DailyExpenseSummary.addAll({date: amount});
      }
    }
    return DailyExpenseSummary;
  }
}
