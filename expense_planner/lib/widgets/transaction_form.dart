import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function _addTransaction;

  const TransactionForm(this._addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime _inputDate;
  var _inputDateChosen = false;

  void _submitForm() {
    final _inputTitle = titleController.text;
    final _inputAmount = double.parse(amountController.text);

    if (_inputTitle.isEmpty || _inputAmount < 0 || !_inputDateChosen) {
      return;
    }

    widget._addTransaction(
      _inputTitle,
      _inputAmount,
      _inputDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _inputDateChosen = true;
        _inputDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                //onChanged: (input) => titleInput = input,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitForm(),
                //onChanged: (input) => amountInput = input,
              ),
              Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      !_inputDateChosen
                          ? "No date chosen !"
                          : "Picked date: ${DateFormat.yMMMEd().format(_inputDate)}",
                      textAlign: TextAlign.left,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        alignment: Alignment.centerRight,
                        textStyle: MaterialStateProperty.all(
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      onPressed: _showDatePicker,
                      child: const Text("Choose Date !"),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text("Add Transaction"),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
