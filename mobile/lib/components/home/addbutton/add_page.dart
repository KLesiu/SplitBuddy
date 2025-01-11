import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newFriendController = TextEditingController();
  final TextEditingController _payingPersonController = TextEditingController();
  String _selectedCurrency = 'USD';
  String _selectedSplitMethod = 'Equally';
  List<String> _friends = ['Bartek', 'Antek', 'Kuba'];
  List<String> _selectedFriends = [];
  DateTime _selectedDate = DateTime.now(); // Domyślnie ustawiona na bieżącą datę
  String? _selectedPayingPerson;

  void _addNewFriend() {
    if (_newFriendController.text.isNotEmpty) {
      setState(() {
        _friends.add(_newFriendController.text);
        _newFriendController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void _showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Friend'),
          content: TextField(
            controller: _newFriendController,
            decoration: InputDecoration(hintText: 'Enter friends name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _addNewFriend,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showFriendSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Friends'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._friends.map((friend) => CheckboxListTile(
                title: Text(friend),
                value: _selectedFriends.contains(friend),
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected == true) {
                      _selectedFriends.add(friend);
                    } else {
                      _selectedFriends.remove(friend);
                    }
                  });
                },
              )),
              TextButton(
                onPressed: _showAddFriendDialog,
                child: Text('Add New Friend'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSplitMethodDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Split Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Equally'),
                onTap: () {
                  setState(() {
                    _selectedSplitMethod = 'Equally';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('By Percentage'),
                onTap: () {
                  setState(() {
                    _selectedSplitMethod = 'By Percentage';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Exact Amounts'),
                onTap: () {
                  setState(() {
                    _selectedSplitMethod = 'Exact Amounts';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addExpense() {
    if (_descriptionController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedFriends.isNotEmpty &&
        _selectedPayingPerson != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Expense added: ${_descriptionController.text}, Amount: ${_amountController.text} $_selectedCurrency, Date: $formattedDate, Split: $_selectedSplitMethod'),
        ),
      );
      _descriptionController.clear();
      _amountController.clear();
      _selectedFriends.clear();
      setState(() {
        _selectedDate = DateTime.now(); // Resetowanie daty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Add New Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showFriendSelectionDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EA95F),
                foregroundColor: Colors.black,
              ),
              child: Text('Select Friends'),
            ),
            SizedBox(height: 12),
            // Display selected friends
            if (_selectedFriends.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _selectedFriends.map((friend) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF4EA95F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity, // Szerokość dopasowana do reszty formularza
                    child: Text(
                      friend,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                }).toList(),
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
            SizedBox(height: 12),
            // Kalendarz i data w jednym kontenerze
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF4EA95F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('yyyy-MM-dd').format(_selectedDate),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            // Nowe pole z osobą płacącą jako Dropdown
            DropdownButtonFormField<String>(
              value: _selectedPayingPerson,
              items: _selectedFriends.map((String friend) {
                return DropdownMenuItem<String>(
                  value: friend,
                  child: Text(friend),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedPayingPerson = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Paying Person',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _showSplitMethodDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EA95F),
                foregroundColor: Colors.black,
              ),
              child: Text('Choose Split Method'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EA95F),
                foregroundColor: Colors.black,
              ),
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
