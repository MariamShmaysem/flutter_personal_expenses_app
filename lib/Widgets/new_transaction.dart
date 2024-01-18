import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();

    // }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('newTransac build() state');
    // final _titleController = TextEditingController();
    // final _amountController = TextEditingController();
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Item'),
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   amountInput = val;
                // },
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Chosen!"
                          : 'Picked date: ${DateFormat().add_yMd().format(_selectedDate!).toString()}'),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text("Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                // () {
                //   // addTransaction(
                //   //     titleController.text, double.parse(_amountController.text));
                //   // debugPrint(titleInput);
                //   // debugPrint(amountInput);
                //   debugPrint(titleController.text);
                //   debugPrint(_amountController.text);
                // },
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
