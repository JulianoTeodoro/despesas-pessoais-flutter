
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
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
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

  final List<Transaction> transactions = [];

  _addTransaction (String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      data: date
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

  _removeTransaction(String id) {
    setState(() {
        transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
          title: Text('Despesas Pessoais',
          style: TextStyle(
            fontSize: 15 * MediaQuery.of(context).textScaleFactor
          )
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => openTransactionModal(context)
            )
          ],
        );
    final avaliableHeight = MediaQuery.of(context).size.height 
    - appBar.preferredSize.height;


    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: TransactionChart(_recentTransactions),
                ),
                Container(
                  height: avaliableHeight * 0.65,
                  child: TransactionList(transactions, _removeTransaction),
                )
                
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