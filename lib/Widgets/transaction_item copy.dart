import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';

class TransactionItem2 extends StatelessWidget {
  const TransactionItem2(this.transaction, this.deleteTx, {Key? key}) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: FittedBox(
            child: Text(
              '\$${transaction.amount!.toStringAsFixed(2)}',
            ),
          ),
        ),
        title: Text(transaction.title.toString(),
            style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date!),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => deleteTx(transaction.id),
                icon: const Icon(Icons.delete),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor),
                label: const Text('Delete'))
            : IconButton(
                onPressed: () => deleteTx(transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
