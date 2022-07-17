import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double value;
  final double porcentage;

  ChartBar({this.label = '', this.value = 0.0, this.porcentage = 0.0});

  @override 
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: FittedBox(
                      child: Text('R\$${value.toStringAsFixed(2)}', 
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    width: 10,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 1.0
                            ),
                            color: Color.fromRGBO(200, 220, 200, 0),
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                        FractionallySizedBox(
                          heightFactor: porcentage,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5)
                              )
                            ),
                          ),
                      ]
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: FittedBox(
                      child: Text(label)
                      
                      ,)
                  )

                ],
              );

      });
  }
}