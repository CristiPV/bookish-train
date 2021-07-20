import 'package:flutter/material.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: "t1", title: "New Laptop", amount: 59.11, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Groceries", amount: 1.11, date: DateTime.now()),
    Transaction(id: "t3", title: "Horse", amount: 100.11, date: DateTime.now()),
    Transaction(id: "t4", title: "Sofa", amount: 20.11, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text("Chart"),
              color: Colors.blue.shade50,
            ),
          ),
          Column(
            children: transactions.map((transaction) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            "${transaction.amount} \$",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              transaction.title.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${transaction.date.month}/${transaction.date.day}/${transaction.date.year}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
