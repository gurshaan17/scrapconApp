import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'user_screens/dashboard_screen.dart'; // Import the DashboardScreen
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsScreen extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 2 of 2',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle Privacy Policy navigation
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                'assets/notification.svg',
                height: 280,
                width: 280,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Stay in the know",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Choose to allow notifications you receive, from order updates to real-time vendor alerts to top details.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () => _requestNotificationPermission(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF17255A),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50), // Full width button
                ),
                child: Text(
                  'Enable Notifications',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50), // Full width button
                ),
                child: Text(
                  'Not now',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _requestNotificationPermission(BuildContext context) async {
    // Initialize the local notifications plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permission for iOS
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // For iOS, you can show a dialog to ask for permission
      // Note: You may need to handle this with a separate package for permissions
      // or use a dialog to inform the user to enable notifications in settings.
      print('Requesting iOS notification permissions...');
    } else {
      // For Android, permissions are granted at install time
      print('Android does not require explicit permission for notifications.');
    }

    // You can now schedule notifications or show a notification
    _showNotification();
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification',
      platformChannelSpecifics,
    );
  }
}