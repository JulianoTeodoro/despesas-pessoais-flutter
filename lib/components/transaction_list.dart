import 'package:estudos/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build (BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ?
      Center(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: <Widget>[
          Text('Nenhuma transação cadastrada', style: Theme.of(context).textTheme.headline6),
          Container(
            height: 200,
            child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          )
         ],
      )
    )
      : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline6
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy - hh:ss').format(tr.data),
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Inter',
                        color: Colors.grey,
                        fontSize: 13
                      ),
                    ),

                  ],
                )
              ]
            ),
          );
        }
      )
    );
}

}