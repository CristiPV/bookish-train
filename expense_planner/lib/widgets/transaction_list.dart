import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: _transactions.length > 0
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child: Text(
                            "${_transactions[index].amount} \$",
                          )),
                        ),
                      ),
                      title: Text(
                        _transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMEd().format(_transactions[index].date),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).primaryColorDark,
                        onPressed: () => _deleteTransaction(index),
                      ),
                    ),
                  );
                  // return Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //   child: Card(
                  //     elevation: 6,
                  //     child: Container(
                  //       padding: EdgeInsets.all(20),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               border: Border.all(
                  //                 color: Theme.of(context).primaryColorLight,
                  //                 width: 2,
                  //                 style: BorderStyle.solid,
                  //               ),
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(15),
                  //               ),
                  //             ),
                  //             padding: EdgeInsets.all(10),
                  //             child: Text(
                  //               "${_transactions[index].amount.toStringAsFixed(2)} \$",
                  //               textAlign: TextAlign.left,
                  //               style: TextStyle(
                  //                 fontFamily: "OpenSans",
                  //                 fontSize: 17,
                  //                 fontStyle: FontStyle.italic,
                  //               ),
                  //             ),
                  //           ),
                  //           Column(
                  //             children: [
                  //               Text(
                  //                 _transactions[index].title.toString(),
                  //                 textAlign: TextAlign.center,
                  //                 style: Theme.of(context).textTheme.headline6,
                  //               ),
                  //               Text(
                  //                 DateFormat.yMMMEd()
                  //                     .format(_transactions[index].date),
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                   fontSize: 15,
                  //                   fontWeight: FontWeight.w300,
                  //                   color: Theme.of(context).accentColor,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
                itemCount: _transactions.length,
              )
            : Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      "No transactions added yet !",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
