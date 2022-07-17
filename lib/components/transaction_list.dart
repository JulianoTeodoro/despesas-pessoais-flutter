import 'package:estudos/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);
  

  @override
  Widget build (BuildContext context) {
    return Container(
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
            margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8
            ),
            elevation: 5,
            child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white
                    )
                ),
                ),
              )
            ),
            title: Text(
                      tr.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                  ),
                ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.data)
            ),
            trailing: IconButton(
              onPressed: () => onRemove(tr.id), 
              icon: Icon(Icons.delete), 
              color: Colors.red
              ),
          ),
          );
        }
      )
    );
}

}

       /* Card(
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
          );*/