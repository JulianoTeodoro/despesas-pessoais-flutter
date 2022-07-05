import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

    final void Function(String, double) onSubmit;
    TransactionForm(this.onSubmit);
    
    @override
    TransactionFormState createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {

  final titleController = TextEditingController();
  final valueController = TextEditingController();

 /* _submitForm () {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value < 0) {
      return;
    }

    widget.onSubmit(title, value);
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              //onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Titulo'
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                      final title = titleController.text;
                      final value = double.tryParse(valueController.text) ?? 0.0;

                      widget.onSubmit(title, value);

                  },
                  child: const Text(
                    'Nova Transação', 
                    style: TextStyle(color: Colors.purple),
                    )
                )
              ],
            )    
          ],
        ),
      ),
    );
  }
}