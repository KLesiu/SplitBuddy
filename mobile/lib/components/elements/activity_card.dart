import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

import 'avatar.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String? description;
  final DateTime timestamp;
  final String firstName;
  final String lastName;

  const ActivityCard({
    required this.title,
    this.description,
    required this.timestamp,
    required this.firstName,
    required this.lastName,
    Key? key,
  }) : super(key: key);

  // 🧠 Funkcja obliczająca, ile czasu temu przyszło powiadomienie
  String getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} minutes ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (difference.inDays == 1) return 'Yesterday';
    return '${difference.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorConstants.primaryColor,
          width: 0.7,
        ),
      ),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Avatar(
                firstName: firstName,
                lastName: lastName,
                size: 60,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (description != null) // ✅ tylko jeśli istnieje
                      Text(
                        description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorConstants.whiteColor,
                        ),
                      ),
                    Text(
                      getTimeAgo(timestamp),
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorConstants.whiteColor,
                      ),
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
