import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

    final void Function(String, double, DateTime) onSubmit;
    TransactionForm(this.onSubmit);
    
    @override
    TransactionFormState createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  var _selectedDate;

   _submitForm () {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value < 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }


  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()
    ).then((value) {
      if(value == null) {
        return;
      }

      _selectedDate = value;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              //onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Titulo'
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$'
              ),
            ),
            Container(
              height: 70,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  _selectedDate == null ? 'Nenhuma data cadastrada' : '${DateFormat('dd/MM/yyyy').format(_selectedDate)}'
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _showDatePicker, 
                  child: Text(
                    'Selecionar data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    )
                  )
              ]
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: _submitForm, 
                  /*() {
                      final title = _titleController.text;
                      final value = double.tryParse(_valueController.text) ?? 0.0;

                      widget.onSubmit(title, value, _selectedDate);

                  }*/
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