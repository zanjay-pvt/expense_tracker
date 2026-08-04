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
  // controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing data from Hive when the app starts
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // Add new expenses dialog
  void AddNewExpenses() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(hintText: "Expense Name"),
            ),
            // Expense amount
            TextField(
              controller: newExpenseAmountController,
              decoration: const InputDecoration(hintText: "Amount"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          MaterialButton(onPressed: Save, child: const Text("Save")),
          MaterialButton(onPressed: Cancel, child: const Text("Cancel")),
        ],
      ),
    );
  }

  // delete
  void deleteExpense(ExpenseItems expense) {
    Provider.of<ExpenseData>(context, listen: false).DeleteExpenses(expense);
  }

  // update
  void editExpense(ExpenseItems expenseToEdit) {
    final editNameController = TextEditingController(text: expenseToEdit.name);
    final editAmountController = TextEditingController(text: expenseToEdit.amount);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editNameController,
              decoration: const InputDecoration(hintText: "Expense Name"),
            ),
            TextField(
              controller: editAmountController,
              decoration: const InputDecoration(hintText: "Amount"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              if (editNameController.text.isNotEmpty &&
                  editAmountController.text.isNotEmpty) {
                ExpenseItems updatedExpense = ExpenseItems(
                  name: editNameController.text,
                  amount: editAmountController.text,
                  time: expenseToEdit.time, // Retains original time/date
                );

                Provider.of<ExpenseData>(context, listen: false)
                    .UpdateExpense(expenseToEdit, updatedExpense);
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // Save
  void Save() {
    // Only save if text fields are not empty
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItems newExpense = ExpenseItems(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        time: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false).AddExpenses(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  // Cancel
  void Cancel() {
    Navigator.pop(context);
    clear();
  }

  // Clear text controller
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: AddNewExpenses,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: ListView(
          children: [
            // Weekly summary graph
            ExpenseSummary(startOfWeek: value.StartOfWeekDate()),
            const SizedBox(height: 20),

            // Expense list view
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) {
                ExpenseItems currentExpense = value.getAllExpenseList()[index];
                return ExpenseTile(
                  name: currentExpense.name.toString(),
                  amount: currentExpense.amount,
                  date: currentExpense.time,
                  deleteTapped: (p0) => deleteExpense(currentExpense),
                  updateTapped: (p0) => editExpense(currentExpense),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}