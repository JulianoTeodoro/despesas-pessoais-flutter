
import 'package:estudos/components/transaction_chart.dart';
import 'package:estudos/components/transaction_list.dart';
import 'package:estudos/components/transaction_form.dart';
import 'package:estudos/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(PerguntaApp());

class PerguntaApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
            fontSize: 18
          )
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.bold
          )
          ),

        )
      );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Geladeira', value: 1200.00, data: DateTime.parse('2022-05-21 12:12')),
    Transaction(id: 't2', title: 'PC', value: 900.00, data: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: 't3', title: 'Airfryer', value: 300.00, data: DateTime.now().subtract(Duration(days: 4))),
  ];


  _addTransaction (String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      data: DateTime.now()
      );
    setState(() {
      transactions.add(newTransaction);
    });
      Navigator.of(context).pop();

  }

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.data.isAfter(DateTime.now().subtract(
        Duration(days:7)
      ));
    }).toList();
  }


  openTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => openTransactionModal(context)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Chart(_recentTransactions),
                TransactionList(transactions),
              ],
            )
          ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => openTransactionModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}