import 'package:flutter/material.dart';

import '../Models/transaction.dart';
import 'Transaction_Item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TransactionList build() state');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView(
            children: 
              transactions.map((e) =>
              TransactionItem(e, deleteTx, key:ValueKey(e.id) ,)).toList(), 
              // Card(
              //   child: Row(
              //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         decoration: BoxDecoration(
              //             border: Border.all(
              //                 color: Theme.of(context).primaryColor,
              //                 width: 2)),
              //         child: Text(
              //           // tx.amount.toString() + "\$"
              //           '\$${transactions[index].amount!.toStringAsFixed(2)}',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               color: Theme.of(context).primaryColor),
              //         ),
              //         padding: const EdgeInsets.all(10),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(transactions[index].title.toString(),
              //               style: Theme.of(context).textTheme.titleLarge),
              //           Text(
              //             DateFormat.yMMMd()
              //                 .format(transactions[index].date!),
              //             style: const TextStyle(color: Colors.grey),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
              // }).toList())
            
            //itemCount: transactions.length
            );

    //       children: transactions.map((tx) {

    // }
  }
}
