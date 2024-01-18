import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(this.transaction, this.deleteTx, {Key? key})
      : super(key: key);
    final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 20,
          child: FittedBox(
            child: Text(
              '\$${widget.transaction.amount!.toStringAsFixed(2)}',
            ),
          ),
        ),
        title: Text(widget.transaction.title.toString(),
            style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date!),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(Icons.delete),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor),
                label: const Text('Delete'))
            : IconButton(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
