import 'package:expense_tracker/models/expense_items.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // Reference our box
  final _myBox = Hive.box("Expense_database");

  // Write data
  void saveData(List<ExpenseItems> allExpense) {
    List<dynamic> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.time,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

    // Using a consistent key name
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  // Read data
  List<ExpenseItems> readData() {
    // Make sure the box key matches what you saved
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItems> allExpense = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // Extract the stored data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // Create the individual expense item
      ExpenseItems expense = ExpenseItems(
        name: name,
        amount: amount,
        time: dateTime,
      );

      // Add it to the list
      allExpense.add(expense);
    }

    return allExpense;
  }
}
