import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final VoidCallback _deleteTransaction;

  const TransactionListItem({
    Key? key,
    required Transaction transaction,
    required VoidCallback deleteTransaction,
  })  : _transaction = transaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "${_transaction.amount} \$",
            )),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(_transaction.date),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).accentColor,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: _deleteTransaction,
                icon: const Icon(Icons.delete),
                label: const Text("Delete Transaction"),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).primaryColorDark,
                onPressed: _deleteTransaction,
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
  }
}
