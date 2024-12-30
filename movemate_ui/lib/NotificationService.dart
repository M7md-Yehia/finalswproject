// // import 'dart:convert';

// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:permission_handler/permission_handler.dart'; // For Android 13+ permissions
// // import 'package:http/http.dart' as http;

// // class NotificationService {
// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
// //   final String baseUrl =
// //       'https://e50b-45-243-12-201.ngrok-free.app'; // Django backend URL
// //   final String authToken; // Pass the token after login

// //   NotificationService(this.authToken);
// //   // Initialize the plugin and create notification channel (Android)
// //   Future<void> init() async {
// //     // Define settings for Android initialization
// //     const AndroidInitializationSettings androidInitializationSettings =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');

// //     // Define initialization settings for iOS (empty for now)
// //     const InitializationSettings initializationSettings =
// //         InitializationSettings(
// //       android: androidInitializationSettings,
// //     );

// //     // Initialize the plugin
// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

// //     // Create notification channel for Android
// //     await _createNotificationChannel();

// //     // For Android 13+, request permission
// //     await _requestNotificationPermission();
// //   }

// //   // Create the notification channel for Android
// //   Future<void> _createNotificationChannel() async {
// //     const AndroidNotificationChannel channel = AndroidNotificationChannel(
// //       'default_channel', // Unique ID for the channel
// //       'Default Notifications', // Name of the channel
// //       description:
// //           'This is the default notification channel', // Description of the channel
// //       importance: Importance.high, // Importance (high, medium, low)
// //       playSound: true, // Whether the notification should play a sound
// //     );

// //     // Register the notification channel with FlutterLocalNotificationsPlugin
// //     await flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             AndroidFlutterLocalNotificationsPlugin>()
// //         ?.createNotificationChannel(channel);
// //   }

// //   // Request notification permission for Android 13+ devices
// //   Future<void> _requestNotificationPermission() async {
// //     if (await Permission.notification.isGranted) {
// //       print("Notification permission granted");
// //     } else {
// //       // Request permission
// //       PermissionStatus status = await Permission.notification.request();
// //       if (status.isGranted) {
// //         print("Notification permission granted");
// //       } else {
// //         print("Notification permission denied");
// //       }
// //     }
// //   }

// //   // Fetch notifications from Django backend
// //   Future<List<Map<String, String>>> fetchNotifications() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/api/auth/notifications/'),
// //       headers: {
// //         'Authorization': 'Bearer $authToken',
// //         'Content-Type': 'application/json',
// //       },
// //     );

// //     if (response.statusCode == 200) {
// //       final List<dynamic> data = json.decode(response.body);

// //       // Convert the data into a List<Map<String, String>>
// //       return data.map((item) {
// //         return {
// //           'title': item['title']?.toString() ?? '',
// //           'message': item['message']?.toString() ?? '',
// //           'created_at': item['created_at']?.toString() ?? '',
// //         };
// //       }).toList();
// //     } else {
// //       throw Exception('Failed to load notifications');
// //     }
// //   }

// //   // Show a notification
// //   Future<void> showNotification() async {
// //     const AndroidNotificationDetails androidNotificationDetails =
// //         AndroidNotificationDetails(
// //       'default_channel', // The ID of the channel we created
// //       'Default Notifications', // The name of the channel
// //       channelDescription: 'This is the default notification channel',
// //       importance: Importance.high, // Importance of the notification
// //       priority: Priority.high, // Priority of the notification
// //       playSound: true, // Sound for the notification
// //     );

// //     const NotificationDetails notificationDetails = NotificationDetails(
// //       android: androidNotificationDetails,
// //     );

// //     await flutterLocalNotificationsPlugin.show(
// //       0, // Notification ID
// //       'Hello!', // Notification title
// //       'This is a notification using the default channel.', // Notification body
// //       notificationDetails, // Platform-specific details
// //     );
// //   }
// // }
// //
// //
// //
// //

// // import 'dart:convert';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:http/http.dart' as http;

// // class NotificationService {
// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
// //   final String baseUrl = 'https://e50b-45-243-12-201.ngrok-free.app';
// //   final String authToken;

// //   NotificationService(this.authToken);

// //   Future<void> init() async {
// //     const AndroidInitializationSettings androidInitializationSettings =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');

// //     const InitializationSettings initializationSettings =
// //         InitializationSettings(android: androidInitializationSettings);

// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

// //     await _createNotificationChannel();
// //     await _requestNotificationPermission();
// //   }

// //   Future<void> _createNotificationChannel() async {
// //     const AndroidNotificationChannel channel = AndroidNotificationChannel(
// //       'default_channel',
// //       'Default Notifications',
// //       description: 'Default notification channel',
// //       importance: Importance.high,
// //     );

// //     await flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             AndroidFlutterLocalNotificationsPlugin>()
// //         ?.createNotificationChannel(channel);
// //   }

// //   Future<void> _requestNotificationPermission() async {
// //     if (await Permission.notification.isGranted) {
// //       print("Notification permission granted");
// //     } else {
// //       PermissionStatus status = await Permission.notification.request();
// //       if (status.isGranted) {
// //         print("Notification permission granted");
// //       } else {
// //         print("Notification permission denied");
// //       }
// //     }
// //   }

// //   Future<void> saveFCMToken() async {
// //     FirebaseMessaging _messaging = FirebaseMessaging.instance;
// //     String? token = await _messaging.getToken();

// //     if (token != null) {
// //       final response = await http.post(
// //         Uri.parse('$baseUrl/api/auth/save-fcm-token/'),
// //         headers: {
// //           'Authorization': 'Bearer $authToken',
// //           'Content-Type': 'application/json',
// //         },
// //         body: json.encode({'fcm_token': token}),
// //       );

// //       if (response.statusCode == 200) {
// //         print("FCM token saved successfully.");
// //       } else {
// //         print("Failed to save FCM token.");
// //       }
// //     }
// //   }

// //   void setupForegroundNotifications() {
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       RemoteNotification? notification = message.notification;
// //       AndroidNotification? android = message.notification?.android;
// //       if (notification != null && android != null) {
// //         flutterLocalNotificationsPlugin.show(
// //           notification.hashCode,
// //           notification.title,
// //           notification.body,
// //           const NotificationDetails(
// //             android: AndroidNotificationDetails(
// //               'default_channel',
// //               'Default Notifications',
// //               channelDescription: 'Default notification channel',
// //               importance: Importance.high,
// //               priority: Priority.high,
// //             ),
// //           ),
// //         );
// //       }
// //     });
// //   }

// //   Future<void> showNotification(String title, String body) async {
// //     const AndroidNotificationDetails androidNotificationDetails =
// //         AndroidNotificationDetails(
// //       'default_channel',
// //       'Default Notifications',
// //       channelDescription: 'This is the default notification channel',
// //       importance: Importance.high,
// //       priority: Priority.high,
// //     );

// //     const NotificationDetails notificationDetails = NotificationDetails(
// //       android: androidNotificationDetails,
// //     );

// //     await flutterLocalNotificationsPlugin.show(
// //       0,
// //       title,
// //       body,
// //       notificationDetails,
// //     );
// //   }
// //}

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(const ShipmentApp());
// }

// class ShipmentApp extends StatelessWidget {
//   const ShipmentApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NotificationWidget(),
//     );
//   }
// }

// class NotificationWidget extends StatefulWidget {
//   const NotificationWidget({Key? key}) : super(key: key);

//   @override
//   State<NotificationWidget> createState() => _NotificationWidgetState();
// }

// class _NotificationWidgetState extends State<NotificationWidget> {
//   late NotificationService _notificationService;

//   @override
//   void initState() {
//     super.initState();
//     _notificationService = NotificationService("your_auth_token_here");
//     _initializeNotificationService();
//   }

//   Future<void> _initializeNotificationService() async {
//     await _notificationService.init();
//     await _notificationService.saveFCMToken();
//     _notificationService.setupForegroundNotifications();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notification Service Example"),
//       ),
//       body: const Center(
//         child: Text("Notification Service Initialized"),
//       ),
//     );
//   }
// }

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final String baseUrl = 'https://e50b-45-243-12-201.ngrok-free.app';
//   final String authToken;

//   NotificationService(this.authToken);

//   Future<void> init() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     await _createNotificationChannel();
//     await _requestNotificationPermission();
//   }

//   Future<void> _createNotificationChannel() async {
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'default_channel',
//       'Default Notifications',
//       description: 'Default notification channel',
//       importance: Importance.high,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }

//   Future<void> _requestNotificationPermission() async {
//     if (await Permission.notification.isGranted) {
//       print("Notification permission granted");
//     } else {
//       PermissionStatus status = await Permission.notification.request();
//       if (status.isGranted) {
//         print("Notification permission granted");
//       } else {
//         print("Notification permission denied");
//       }
//     }
//   }

//   Future<void> saveFCMToken() async {
//     FirebaseMessaging _messaging = FirebaseMessaging.instance;
//     String? token = await _messaging.getToken();

//     if (token != null) {
//       final response = await http.post(
//         Uri.parse('$baseUrl/api/auth/save-fcm-token/'),
//         headers: {
//           'Authorization': 'Bearer $authToken',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({'fcm_token': token}),
//       );

//       if (response.statusCode == 200) {
//         print("FCM token saved successfully.");
//       } else {
//         print("Failed to save FCM token.");
//       }
//     }
//   }

//   void setupForegroundNotifications() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'default_channel',
//               'Default Notifications',
//               channelDescription: 'Default notification channel',
//               importance: Importance.high,
//               priority: Priority.high,
//             ),
//           ),
//         );
//       }
//     });
//   }

//   Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'default_channel',
//       'Default Notifications',
//       channelDescription: 'This is the default notification channel',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
// }
