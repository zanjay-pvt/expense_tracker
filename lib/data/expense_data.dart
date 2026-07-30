import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //List of all expenses
  List<ExpenseItems> overallexpenseList = [];

  //Get expense list
  List<ExpenseItems> getAllExpenseList() {
    return overallexpenseList;
  }

  //Add expenses
  void AddExpenses(ExpenseItems newExpense) {
    overallexpenseList.add(newExpense);
    notifyListeners();
  }

  //delete expenses
  void DeleteExpenses(ExpenseItems expense) {
    overallexpenseList.remove(expense);
    notifyListeners();
  }
  //get weekday (mon,tues, etc)from a datetime objective

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

  //get the date for the start of the week (sunday)
  DateTime StartOfWeekDate() {
    DateTime? startOfWeek;

    //get today date
    DateTime today = DateTime.now();

    //go backward from  today to find the sunday

    for (int i = 0; i < 7; i++) {
      if (GetDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /* convert  overall expenses in daily expenses summary
  
  eg:
  overallexpenses = [
  [food,2023/01/01,$10],
  [food,2023/01/01,$10],
  [food,2023/01/01,$10],
  [food,2023/01/01,$10]

  
  ]
  

  ->
  dailyExpenseSummary = [
  [2023/01/01:$10],
  [2023/01/01:$10],
  [2023/01/01:$10],
  [2023/01/01:$10],
  ]
  */
  Map<String, double> CalculateDailyExpenseSummary() {
    Map<String, double> DailyExpenseSummary = {
      //date(yyyymmdd) : amountof total
    };

    for (var expense in overallexpenseList) {
      String date = ConvertDateTime(expense.time);
      double amount = double.parse(expense.amount);

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
