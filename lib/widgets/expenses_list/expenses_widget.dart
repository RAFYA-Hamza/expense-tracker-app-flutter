import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({
    required this.expense,
    required this.onRemoveExpense,
    super.key,
  });
  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;

  Widget containerWidget(
      AlignmentGeometry alignment, EdgeInsetsGeometry padding) {
    return Container(
      alignment: alignment,
      color: Colors.red,
      child: Padding(
        padding: padding,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            padding:
                EdgeInsets.all(Theme.of(context).cardTheme.margin!.horizontal),
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          key: ValueKey(expense[index]),
          onDismissed: (direction) {
            onRemoveExpense(expense[index]);
          },
          child: SizedBox(
            height: 100,
            child: Card(
              child: Center(
                child: ListTile(
                  title: Text(
                    expense[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    '\$ ${expense[index].amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 105,
                        child: Row(
                          children: [
                            Icon(categoryIcons[expense[index].category]),
                            const SizedBox(width: 8),
                            Text(
                              expense[index].formattedDate,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
