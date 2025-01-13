import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

class EditGroupWidget extends StatefulWidget {
  final String groupName;

  EditGroupWidget({Key? key, required this.groupName}) : super(key: key);

  @override
  _EditGroupWidgetState createState() => _EditGroupWidgetState();
}

class _EditGroupWidgetState extends State<EditGroupWidget> {
  List<Map<String, dynamic>> _expenses = [];
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCurrency = 'USD';

  void _addExpense() {
    if (_descriptionController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _expenses.add({
          'description': _descriptionController.text,
          'amount': double.tryParse(_amountController.text) ?? 0.0,
          'currency': _selectedCurrency,
        });
      });
      _descriptionController.clear();
      _amountController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddExpenseDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Expense',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                items: ['USD', 'EUR', 'PLN'].map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCurrency = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Currency',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.secondaryColor,
                  foregroundColor: Colors.black,
                ),
                child: Text('Add Expense'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        title: Text(widget.groupName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showAddExpenseDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.secondaryColor,
                foregroundColor: Colors.black,
              ),
              child: Text('Add New Expense'),
            ),
            SizedBox(height: 16),
            Text(
              'Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _expenses.isEmpty
                  ? Center(
                child: Text(
                  'No expenses added yet.',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  var expense = _expenses[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(expense['description']),
                      subtitle: Text(
                          '${expense['amount'].toStringAsFixed(2)} ${expense['currency']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

