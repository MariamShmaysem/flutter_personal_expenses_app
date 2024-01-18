import 'package:flutter/material.dart';
import 'package:personalexpenses/Models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personalexpenses/Widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction>? recentTransactions;
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions!.length; i++) {
        if (recentTransactions![i].date!.day == weekDay.day &&
            recentTransactions![i].date!.month == weekDay.month &&
            recentTransactions![i].date!.year == weekDay.year) {
          totalSum += recentTransactions![i].amount!;
        }
      }
      debugPrint(DateFormat.E().format(weekDay).toString());
      debugPrint(totalSum.toString());
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, e) {
      return sum + double.parse(e['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Chart build() state');
    debugPrint(groupedTransactionValues.toString());
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return //Text(' ${e['day']}  : ${e['amount']}')
                Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  e['day'].toString(),
                  double.parse(e['amount'].toString()),
                  (maxSpending == 0.0)
                      ? 0.0
                      : double.parse(e['amount'].toString() ) / maxSpending),
                     
            );
          }).toList(),
        ),
      ),
    );
  }
}
