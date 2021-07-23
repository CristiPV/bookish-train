import 'package:flutter/material.dart';

import './transaction_list_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  const TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: _transactions.length > 0
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionListItem(
                      transaction: _transactions[index],
                      deleteTransaction: () => _deleteTransaction(index));
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