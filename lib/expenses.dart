import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_widget.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registredExpense = [
    Expense(
      title: "Food",
      amount: 23.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Work",
      amount: 24.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Work",
      amount: 24.0,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      constraints: const BoxConstraints.expand(
        height: double.infinity,
        width: double.infinity,
      ),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addNewExpense),
    );
  }

  void addNewExpense(Expense newExpenseElement) {
    setState(() {
      _registredExpense.add(newExpenseElement);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registredExpense.indexOf(expense);

    setState(() {
      _registredExpense.remove(expense);
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expense deleted!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Expense Tracker",
          style: TextStyle(
              // fontSize: 12,
              ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registredExpense),
                _registredExpense.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text(
                            "No expenses Found. Start adding some!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ExpensesWidget(
                          onRemoveExpense: _removeExpense,
                          expense: _registredExpense,
                        ),
                      ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registredExpense),
                ),
                _registredExpense.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text(
                            "No expenses Found. Start adding some!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ExpensesWidget(
                          onRemoveExpense: _removeExpense,
                          expense: _registredExpense,
                        ),
                      ),
              ],
            ),
    );
  }
}
