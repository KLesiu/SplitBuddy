import 'package:flutter/material.dart';
import 'package:split_buddy/components/elements/activity_card.dart';
import 'package:split_buddy/components/elements/custom-form-input.dart';
import 'package:split_buddy/constants/color-constants.dart';

import '../../../services/httpService.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final HttpService httpService = HttpService();
  List<Map<String, dynamic>> notifications = [];
  final TextEditingController searchController = TextEditingController();

  // void getNotifications() async {
  //   var response = await httpService.get("/api/Notifications/getAll");
  //   if (response == null) return;
  //   var result = jsonDecode(response.body);
  //   if (result != null && result is List) {
  //     setState(() {
  //       notifications = List<Map<String, dynamic>>.from(result as Iterable);
  //     });
  //   }
  // }

  void getNotifications() async {
    setState(() {
      notifications = [
        {
          'title': 'Tymczasowe rozwiązanie',
          'message': 'Anna added a new expense to Trip to Rome',
          'subtitle': '3 minutes ago',
        },
        {
          'title': 'Payment received',
          'message': 'You received 25 PLN from Mark',
          'subtitle': '1 hour ago',
        },
        {
          'title': 'Reminder',
          'message': 'Don\'t forget to settle up with Julia',
          'subtitle': 'Yesterday',
        },
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorConstants.primaryColor,
            size: 40,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Recent activity',
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Column(
          children: [
            if (notifications.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomFormInput(
                  controller: searchController,
                  labelText: 'Search...',
                  icon: Icons.search,
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: notifications.isEmpty
                    ? Center(
                        child: Text(
                          'No activities yet.',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.whiteColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return ActivityCard(
                            title: notifications[index]['title'] ?? 'No title',
                            description:
                                notifications[index]['message'] ?? 'No message',
                            subtitle:
                                notifications[index]['message'] ?? 'No message',
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
