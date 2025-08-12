import 'package:flutter/material.dart';

import '../../../constants/color-constants.dart';
import '../../../services/httpService.dart';
import '../../elements/custom-button.dart';
import '../../elements/custom-form-input.dart';
import '../../elements/enums/button_font.dart';
import '../../elements/enums/button_size.dart';
import '../../elements/enums/button_style.dart';
import '../../elements/friend_option.dart'; // *** ADDED: import komponentu friend_option ***

class AddFriendWidget extends StatelessWidget {
  final Function() onFriendAdded;
  final HttpService httpService = HttpService();

  AddFriendWidget({Key? key, required this.onFriendAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF4EA95F),
      onPressed: () {
        _showAddFriendDialog(context);
      },
      child: Icon(
        Icons.add_rounded,
        // zamiana z Icons.add na add_rounded dla grubszej ikony
        size:
            45, // zwiększenie rozmiaru, żeby plusik był większy i bardziej widoczny
        color: Colors.black,
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // *** ADDED: tymczasowa lista sugestii / wyników do podglądu (później -> API) ***
    final List<Map<String, String>> suggestions = [
      {
        'name': 'Anna',
        'surname': 'Kowalska',
        'email': 'anna.kowalska@example.com',
      },
      {
        'name': 'Piotr',
        'surname': 'Nowak',
        'email': 'piotr.nowak@example.com',
      },
      {
        'name': 'Maria',
        'surname': 'Wiśniewska',
        'email': 'maria.wisniewska@example.com',
      },
    ];

    // istniejąca funkcja używana przy kliknięciu "Add Friend" (z pola)
    void addFriend() async {
      var body = {'email': emailController.text};
      var response = await httpService.post("/api/Friendship/addFriend", body);
      if (response == null) return;
      var result = response.body;
      if (result == null) return;
      Navigator.of(context).pop();
      onFriendAdded();
    }

    // *** ADDED: pomocnicza funkcja do dodania znajomego na podstawie wybranej propozycji ***
    Future<void> addFriendWithEmail(String email) async {
      var body = {'email': email};
      var response = await httpService.post("/api/Friendship/addFriend", body);
      if (response == null) return;
      var result = response.body;
      if (result == null) return;
      Navigator.of(context).pop();
      onFriendAdded();
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorConstants.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.85, // szerokość dialogu
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add friends',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ColorConstants.whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFormInput(
                        controller: emailController,
                        labelText: 'Friend Email',
                        icon: Icons.search,
                        fillColor: ColorConstants.homeBackgroundColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 0.75,
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Send invites to:',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1, color: Colors.white24),
                          itemBuilder: (context, index) {
                            final friend = suggestions[index];
                            return FriendOption(
                              name: friend['name']!,
                              surname: friend['surname']!,
                              onTap: () {
                                addFriendWithEmail(friend['email']!);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            style: ButtonStyleType
                                .Outline, // zakładam, że masz styl 'Danger' na czerwony (dla Cancel)
                            text: 'Cancel',
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                            size:
                                ButtonSize.M, // dobierz rozmiar według potrzeb
                            fontSize: ButtonFontSize.Medium,
                            fontWeight: FontWeight.normal,
                          ),
                          const SizedBox(
                              width: 16), // odstęp między przyciskami
                          CustomButton(
                            style: ButtonStyleType
                                .Success, // zielony przycisk 'Add Friend'
                            text: 'Send requests',
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                addFriend();
                              }
                            },
                            size: ButtonSize.M,
                            fontSize: ButtonFontSize.Medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
