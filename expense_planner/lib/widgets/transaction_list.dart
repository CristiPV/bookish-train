import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
                    trailing: Text(
                      "Delete Button",
                      style: TextStyle(
                        fontSize: 10,
                      ),
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
                Text(
                  "No transactions added yet !",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
    );
  }
}
