import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as developer;

class NotificationService {
  static Future initializeNoti(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      var AndroidInitialize =
          new AndroidInitializationSettings('@mipmap/ic_launcher');
      var initiazeionsSitting =
          new InitializationSettings(android: AndroidInitialize);
      await flutterLocalNotificationsPlugin.initialize(initiazeionsSitting);
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  static Future showBigTextnoti(
      {var id = 0,
      required String name,
      required String body,
      var playload,
      required FlutterLocalNotificationsPlugin fln}) async {
    try {
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails('2', "flutterEmbedding",
              playSound: true,
              importance: Importance.max,
              priority: Priority.high);
      var not = NotificationDetails(android: androidNotificationDetails);
      await fln.show(0, name, body, not);
    } on Exception catch (e) {
      developer.log("showBigTextnoti");
      developer.log(e.toString());
    }
  }
}
