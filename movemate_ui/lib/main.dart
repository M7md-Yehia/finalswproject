import 'package:flutter/material.dart';
import 'package:movemate_ui/NotificationService.dart';
import 'package:movemate_ui/main_pages/HomeDelivery.dart';
import 'package:movemate_ui/main_pages/HomePage.dart';
import 'package:movemate_ui/main_pages/Profile.dart';
import 'package:movemate_ui/main_pages/login.dart';
import 'package:movemate_ui/navigation_view.dart';
import 'package:movemate_ui/main_pages/register.dart';
import 'package:movemate_ui/main_pages/shipment_history.dart';

void main() {
  runApp(const ShipmentApp());
}

class ShipmentApp extends StatelessWidget {
  const ShipmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'NotificationService.dart'; // Import the notification service

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Notification Demo',
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final NotificationService _notificationService =
//       NotificationService('2qHAXXUEiiAWCUfjENXjxBhlTWi_2dXFbSVoTYxnfMewgXhKx');

//   @override
//   void initState() {
//     super.initState();
//     _notificationService.init(); // Initialize the notification service
//   }

//   // Trigger the notification when the button is pressed
//   void _showNotification() {
//     _notificationService.showNotification(); // Show the notification
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Flutter Notification Demo',
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showNotification, // Call the method to show notification
//           child: const Text('Show Notification'),
//         ),
//       ),
//     );
//   }
// }
