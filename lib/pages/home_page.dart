import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  //AddnewExpenses
  void AddNewExpenses() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Expense name
            TextField(controller: newExpenseNameController),
            //expense amount
            TextField(controller: newExpenseAmountController),
          ],
        ),
        actions: [
          MaterialButton(onPressed: Save, child: Text("Save")),

          MaterialButton(onPressed: Cancel, child: Text("Cancel")),
        ],
      ),
    );
  }

  //Save
  void Save() {
    ExpenseItems newExpense = ExpenseItems(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      time: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).AddExpenses(newExpense);

    Navigator.pop(context);
    clear();
  }

  //cancel
  void Cancel() {}

  //clear text controller
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: AddNewExpenses,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [

            //weekly summary
            ExpenseSummary(startOfWeek: value.StartOfWeekDate()),
            //expence summary
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name.toString(),
                amount: value.getAllExpenseList()[index].amount,
                date: value.getAllExpenseList()[index].time,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
