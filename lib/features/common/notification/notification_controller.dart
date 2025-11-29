import 'dart:io';
import 'package:dermaininstitute/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

/// Background handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('📤 Background message received: ${message.notification?.title}');
}

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  var fcmToken = ''.obs;
  var lastMessage = ''.obs;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initLocalNotifications();
    _initFirebaseMessaging();
  }

  /// Initialize local notifications
  void _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification clicked with payload: ${response.payload}');
      },
    );
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

  /// Initialize Firebase Messaging
  Future<void> _initFirebaseMessaging() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Request permission for iOS only
    if (Platform.isIOS) {
      NotificationSettings settings = await FirebaseMessaging.instance
          .requestPermission(alert: true, badge: true, sound: true);
      debugPrint('📌 User granted permission: ${settings.authorizationStatus}');
    }

    // Get FCM token safely
    try {
      String? token;
      if (Platform.isAndroid) {
        token = await FirebaseMessaging.instance.getToken();
      } else if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        debugPrint("APNS Token: $apnsToken");
        token = await FirebaseMessaging.instance.getToken();
      }

      if (token != null) {
        fcmToken.value = token;
        debugPrint('🔑 FCM Token: $token');
      }
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
    }

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        '📩 Foreground message: ${message.notification?.title} - ${message.notification?.body}',
      );
      lastMessage.value = message.notification?.title ?? "No Title";

      _showLocalNotification(
        title: message.notification?.title ?? "New Message",
        body: message.notification?.body ?? "",
      );
    });

    // When app is opened from background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📲 Opened from notification: ${message.notification?.title}');
      lastMessage.value = message.notification?.title ?? "No Title";
    });

    // When app is opened from terminated state
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        '📥 App opened from terminated state: ${initialMessage.notification?.title}',
      );
      lastMessage.value = initialMessage.notification?.title ?? "No Title";
    }

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
