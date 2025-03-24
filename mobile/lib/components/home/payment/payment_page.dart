import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/httpService.dart';
import '../../../constants/color-constants.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final HttpService httpService = HttpService();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newFriendController = TextEditingController();
  final TextEditingController _payingPersonController = TextEditingController();
  String selectedCurrency = 'USD';
  String selectedSplitMethod = 'Equally';
  List<Map<String, dynamic>> friends = [];
  List<dynamic> groups = [];

  List<Map<String, dynamic>> selectedFriends = [];
  List<Map<String, dynamic>> selectedGroups = [];

  DateTime selectedDate = DateTime.now();
  String? _selectedPayingPerson;

  Future<void> getGroups() async {
    var response = await httpService.get("/api/Group/getAllUserGroups");
    if (response == null) return;
    var result = jsonDecode(response.body);
    if (result != null && result is List) {
      setState(() {
        groups = List<Map<String, dynamic>>.from(result as Iterable);
      });
    }
  }
  Future<void> getGroupMemberships()async{
    var body = {
      'groupId':selectedGroups[0]['id']
    };
    var response = await httpService.post("/api/GroupMembership/getGroupMemberships", body);
    if(response == null)return;
    var result =  jsonDecode(response.body);
    if(result == null)return;
    setState(() {
      friends = List<Map<String, dynamic>>.from(result as Iterable);
    });
  }



  void showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.homeBackgroundColor,
          title: Text('Add New Friend', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _newFriendController,
            decoration: InputDecoration(
                hintText: 'Enter friends name',
            hintStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
        TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Cancel', style: TextStyle(color: Colors.redAccent)),
        ),
        TextButton(
        onPressed: (){},
        child: Text('Add', style: TextStyle(color: Colors.greenAccent)),
        ),
        ],
        );
      },
    );
  }

  void showGroupSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              backgroundColor: ColorConstants.homeBackgroundColor,
              title: Text('Select Group', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: groups.map((group) {
                  return RadioListTile<Map<String, dynamic>>(
                    title: Text(group["name"], style: TextStyle(color: Colors.white)),
                    value: group,
                    groupValue: selectedGroups.isNotEmpty
                        ? selectedGroups[0]
                        : null,
                    onChanged: (Map<String, dynamic>? selectedGroup) {
                      setDialogState(() {
                        selectedGroups =
                        selectedGroup != null ? [selectedGroup] : [];
                      });
                    },
                    activeColor: Colors.greenAccent,
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () async{
                    setState(() {});
                    await getGroupMemberships();
                    Navigator.of(context).pop();
                  },
                  child: Text('Close', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showFriendSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              backgroundColor: ColorConstants.homeBackgroundColor,
              title: Text('Select Friends', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...friends.map((friend) {
                    bool isSelected = selectedFriends.contains(friend);
                    return CheckboxListTile(
                      title: Text(friend['user']['username'], style: TextStyle(color: Colors.white)),
                      value: isSelected,
                      onChanged: (bool? selected) {
                        setDialogState(() {
                          if (selected == true) {
                            selectedFriends.add(friend);
                          } else {
                            selectedFriends.remove(friend);
                          }
                        });
                        print(selectedFriends);
                      },
                      checkColor: Colors.black,
                      activeColor: Colors.greenAccent,
                    );
                  }).toList(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showSplitMethodDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: ColorConstants.homeBackgroundColor,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Split Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              ListTile(
                title: Text('Equally', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedSplitMethod = 'Equally';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('By Percentage', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedSplitMethod = 'By Percentage';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Exact Amounts', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedSplitMethod = 'Exact Amounts';
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

  void addExpense() {
    if (_descriptionController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        selectedFriends.isNotEmpty &&
        _selectedPayingPerson != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Expense added: ${_descriptionController.text}, Amount: ${_amountController.text} $selectedCurrency, Date: $formattedDate, Split: $selectedSplitMethod'),
        ),
      );
      _descriptionController.clear();
      _amountController.clear();
      selectedFriends.clear();
      setState(() {
        selectedDate = DateTime.now(); // Resetowanie daty
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Add New Expense'),
      ),
      body: Container(
        color: ColorConstants.homeBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: showGroupSelectionDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
              ),
              child: Text('Select Group'),
            ),
            SizedBox(height: 12),
            if (selectedGroups.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Group: ${selectedGroups[0]["name"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: showFriendSelectionDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('Select Friends'),
                  ),
                  SizedBox(height: 12),
                  if (selectedFriends.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: selectedFriends.map((friend) {
                        return Chip(
                          label: Text(friend['user']['username'], style: TextStyle(color: Colors.black)),
                          backgroundColor: Colors.greenAccent,
                        );
                      }).toList(),
                    ),

                ],
              ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCurrency,
              items: ['USD', 'EUR', 'PLN'].map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCurrency = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Currency',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




