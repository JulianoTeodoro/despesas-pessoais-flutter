import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/chart_bar.dart';
import '../models/transaction.dart';

class TransactionChart extends StatelessWidget {

  final List<Transaction> recentTransaction;

  TransactionChart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      double totalSum = 0.0;

      for(var i = 0; i < recentTransaction.length; i++) {
        bool sameDays = recentTransaction[i].data.day == weekDay.day;
        bool sameMonth = recentTransaction[i].data.month == weekDay.month;
        bool sameYear = recentTransaction[i].data.year == weekDay.year;

        if(sameDays && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {
        'day' : DateFormat.E().format(weekDay)[0],
        'value': totalSum
      };
    }).reversed.toList();
  }
  double get _chartPercentage {
    return groupedTransactions.fold(0, (acc, tr) {
      return acc + (tr['value'] as double);
    });
  }


  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
        children: groupedTransactions.map((tr) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(label: tr['day'].toString(), value: tr['value'] as double, porcentage: _chartPercentage == 0 ? 0 : (tr['value'] as double) / _chartPercentage ),
          );
        }).toList(),
      ),
      )
    );
  }

}