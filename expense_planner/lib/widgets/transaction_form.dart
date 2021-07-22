import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function _addTransaction;

  TransactionForm(this._addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitForm() {
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount < 0) {
      return;
    }

    widget._addTransaction(
      inputTitle,
      inputAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitForm(),
              //onChanged: (input) => titleInput = input,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitForm(),
              //onChanged: (input) => amountInput = input,
            ),
            ElevatedButton(
              child: Text("Add Transaction"),
              onPressed: submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
