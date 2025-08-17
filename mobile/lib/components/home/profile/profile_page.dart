// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:split_buddy/components/elements/avatar_text.dart';
//
// import '../../../constants/color-constants.dart';
// import '../../../services/httpService.dart';
// import '../../../stores/userStore.dart';
// import '../../layout/header.dart';
// import '../payment/payment_page.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final UserStore userStore = UserStore();
//   final HttpService httpService = HttpService();
//
//   String? username;
//   String? email;
//   bool isLoading = true;
//   String? errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   Future<void> fetchUserData() async {
//     try {
//       var response = await httpService.get("/api/User/getUser");
//       if (response != null && response.body != null) {
//         var body = jsonDecode(response.body);
//         setState(() {
//           username = body["username"];
//           email = body["email"];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'No user data available!';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Something went wrong!';
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Header(
//         username: username ?? '',
//         firstName: 'Norbert',
//         lastName: 'Gierczak',
//       ),
//       body: Container(
//         color: ColorConstants.backgroundColor,
//         padding: const EdgeInsets.all(16.0),
//         child: isLoading
//             ? Center(child: CircularProgressIndicator())
//             : errorMessage != null
//                 ? Center(
//                     child: Text(
//                       errorMessage!,
//                       style: TextStyle(color: Colors.red, fontSize: 18),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       Row(
//                         children: [
//                           AvatarText(
//                             firstName: 'Norbert',
//                             lastName: 'Gierczak',
//                             size: 60,
//                           ),
//                           SizedBox(width: 16),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 username ?? '',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 email ?? '',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => PaymentPage()),
//                                 );
//                               },
//                               icon: Icon(Icons.add_circle_outline,
//                                   color: Colors.black),
//                               label: Text('New Split'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent,
//                                 foregroundColor: Colors.black,
//                                 minimumSize: Size(double.infinity, 50),
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 // TODO: navigate to My Groups page
//                               },
//                               icon: Icon(Icons.group, color: Colors.black),
//                               label: Text('My Groups'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent,
//                                 foregroundColor: Colors.black,
//                                 minimumSize: Size(double.infinity, 50),
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 // TODO: navigate to My Friends page
//                               },
//                               icon: Icon(Icons.people, color: Colors.black),
//                               label: Text('My Friends'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent,
//                                 foregroundColor: Colors.black,
//                                 minimumSize: Size(double.infinity, 50),
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 // TODO: navigate to History page
//                               },
//                               icon: Icon(Icons.history, color: Colors.black),
//                               label: Text('History'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent,
//                                 foregroundColor: Colors.black,
//                                 minimumSize: Size(double.infinity, 50),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/components/home/profile/profile_page_friend/profile_page_friends.dart';
import 'package:split_buddy/components/home/profile/profile_page_group/profile_page_groups.dart';

import '../../../constants/color-constants.dart';
import '../../../services/httpService.dart';
import '../../../stores/userStore.dart';
import '../../layout/header.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserStore userStore = UserStore();
  final HttpService httpService = HttpService();

  String? username;
  String? email;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      var response = await httpService.get("/api/User/getUser");
      if (response != null && response.body != null) {
        var body = jsonDecode(response.body);
        setState(() {
          username = body["username"];
          email = body["email"];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No user data available!';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong!';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: Header(
        username: username ?? '',
        firstName: 'Norbert',
        lastName: 'Gierczak',
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // REMOVED: cała stara sekcja z AvatarText, email, i przyciskami ElevatedButton
                        // CHANGED: wstawiamy gotowe komponenty sekcji
                        ProfilePageGroups(), // „My Groups” – wewnątrz używa CustomButton (okrągły „+”, ikony home/work, poziomy układ)
                        SizedBox(height: 24),
                        ProfilePageFriends(), // „My Friends” – wewnątrz używa CustomButton (okrągły „+”), karty jako przyciski z AvatarText, poziomy układ
                      ],
                    ),
                  ),
      ),
    );
  }
}
