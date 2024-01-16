// // import 'dart:io';

// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // // import 'package:lost_finder/core/utils/all_constants.dart';
// // // import 'package:lost_finder/screens/06_details_screen/details_screen.dart';
// // // ignore: depend_on_referenced_packages
// // import 'package:timezone/data/latest.dart' as tz;
// // // ignore: depend_on_referenced_packages
// // import 'package:timezone/timezone.dart' as tz;

// // class NotificationService {
// //   ///In this Class we have to set the Notifications for a reminder.
// //   ///First we have get the refrence of the notifications from the plugin=>fluttter_local_notifications

// //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   NotificationService();

// //   ///in this method we are intializing the flutter_local_notifications
// //   ///We will call this method in the CreateReminderScreen inside InitState(){}
// //   ///to make sure initalization
// //   ///
// //   ///*************Important****************/
// //   ///I Have pass the Context Because I want to navigate to the DetailsScreen
// //   ///If the Data did not work Remove the Context From init()
// //   ///          ||
// //   ///          ||
// //   ///          \/
// //   init(BuildContext context) async {
// //     ///Getting the current timezone
// //     final String currentTimeZone =
// //         await FlutterNativeTimezone.getLocalTimezone();
// //     tz.initializeTimeZones();
// //     tz.setLocalLocation(tz.getLocation(currentTimeZone));

// //     ///Declaring the Android Notification Settings for Android Only
// //     AndroidInitializationSettings androidInitializationSettings =
// //         const AndroidInitializationSettings('@mipmap/ic_launcher');

// //     ///Declaring the IOs Notification Settings for IOs

// //     // IOSInitializationSettings iosInitializationSettings =
// //     //     IOSInitializationSettings();

// //     ///Intializing the Settings for both IOs and Android
// //     InitializationSettings initializationSettings = InitializationSettings(
// //       android: androidInitializationSettings,
// //       // iOS: iosInitializationSettings,
// //     );

// //     flutterLocalNotificationsPlugin.initialize(
// //       initializationSettings,

// //       /// ====>>> Here you have to pass the Payload to Navigate to the Spesific Screen

// //       // onDidReceiveBackgroundNotificationResponse: (details) {
// //       //   final reminder = fetchReminderModel(int.parse(details.payload!));

// //       //   Navigator.push(
// //       //     context,
// //       //     MaterialPageRoute(
// //       //       builder: (context) => DetailsScreen(
// //       //         reminderModel: reminder!,
// //       //       ),
// //       //     ),
// //       //   );
// //       // },
// //     );
// //   }

// //   ///Fetch Box to assign to the DetailsScreen

// //   ReminderModel fetchReminderModel(int key) {
// //     final reminderBox = ReminderBox.getReminder();
// //     final reminder = reminderBox.get(key)!;
// //     return reminder;
// //   }

// // //******************************Playing With Notification*********** */
// //   ///Here we have to Design the Notification for IOs that how our Notification look alike
// //   ///on Platform IOs
// //   getIosNotificationDetails() {
// //     // return IOSNotificationDetails();
// //   }

// //   ///Here we have to Design the Notification for IOs that how our Notification look alike
// //   ///on Platform Android
// //   AndroidNotificationDetails androidNotificationDetails(String largeIconPath) {
// //     return AndroidNotificationDetails(
// //       'reminder',
// //       'Reminder Notification',
// //       channelDescription: 'Notification sent as reminder',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //       enableVibration: true,
// //       category: AndroidNotificationCategory.alarm,

// //       ///App Icon
// //       icon: '@mipmap/ic_launcher',

// //       ///Reminder Image
// //       largeIcon: FilePathAndroidBitmap(largeIconPath),
// //       groupKey: 'com.varadgauthankar.simple_reminder.REMINDER',
// //     );
// //   }

// //   ///To Check the Image is Available or not
// //   Future<String> loadImagePath(String imagePath) async {
// //     final file = File(imagePath);
// //     final exists = await file.exists();

// //     if (exists) {
// //       return imagePath;
// //     } else {
// //       throw Exception('Image file not found');
// //     }
// //   }

// //   ///This is the Actual Notification that will PopUp when the Reminder time == Current time
// //   Future scheduleNotification(ReminderModel reminder) async {
// //     // ignore: unnecessary_null_comparison
// //     if (reminder.time != null) {
// //       final imagePath = reminder.image;
// //       final largeIconPath = await loadImagePath(imagePath);
// //       flutterLocalNotificationsPlugin.zonedSchedule(
// //         reminder.key,
// //         reminder.title,
// //         reminder.description,
// //         notificationTime(reminder.time),
// //         payload: reminder.key.toString(),
// //         NotificationDetails(
// //           android: androidNotificationDetails(largeIconPath),
// //           iOS: getIosNotificationDetails(),
// //         ),
// //         uiLocalNotificationDateInterpretation:
// //             UILocalNotificationDateInterpretation.absoluteTime,
// //         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// //       );
// //       debugPrint('notification set at ${reminder.time}');
// //     } else {
// //       return;
// //     }
// //   }

// //   ///We check either a reminder has a notification or not
// //   ///We use this method to update the exsisting Reminder.
// //   Future<bool> reminderHasNotification(ReminderModel reminder) async {
// //     var pendingNotifications =
// //         await flutterLocalNotificationsPlugin.pendingNotificationRequests();
// //     return pendingNotifications
// //         .any((notification) => notification.id == reminder.key);
// //   }

// //   ///To Update the reminder that when it has Updated the time
// //   ///We cancel the previous Notification and create a new Notification(Updated one)
// //   void updateNotification(ReminderModel reminder) async {
// //     var hasNotification = await reminderHasNotification(reminder);
// //     if (hasNotification) {
// //       flutterLocalNotificationsPlugin.cancel(reminder.key);
// //     }

// //     scheduleNotification(reminder);
// //   }

// //   ///To Cancel A Notification when a reminder is deleted
// //   ///or Updated the already created Notification for the Reminder is Canceled by this
// //   void cancelNotification(int id) {
// //     flutterLocalNotificationsPlugin.cancel(id);
// //     debugPrint('$id canceled');
// //   }

// //   tz.TZDateTime notificationTime(DateTime dateTime) {
// //     return tz.TZDateTime(
// //       tz.local,
// //       dateTime.year,
// //       dateTime.month,
// //       dateTime.day,
// //       dateTime.hour,
// //       dateTime.minute,
// //       dateTime.second,
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:isolate_handler/isolate_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:workmanager/workmanager.dart';

// class Task {
//   final String id;
//   final String title;
//   final DateTime deadline;
//   bool completed;

//   Task({required this.id, required this.title, required this.deadline, this.completed = false});
// }

// final tasksProvider = Provider<List<Task>>((ref) => []);
// // Background isolate handler
// final _isolateHandler = IsolateHandler();

// // Background alarm service
// Future<void> scheduleAlarmCheck( BuildContext context) async {
//   await _isolateHandler.spawn(
//     (contexts) async {
//       while (true) {
//         await Future.delayed(const Duration(minutes: 5)); // Adjust check interval
//         // ignore: use_build_context_synchronously
//         final tasks = Provider.of<List<Task>>(context , listen: false);
//         final completedTasks = tasks.where((task) => task.deadline.isBefore(DateTime.now()) && !task.completed).toList();
//         if (completedTasks.isNotEmpty) {
//           for (final task in completedTasks) {
//             await scheduleLocalNotification(task.title); // Trigger notification
//             task.completed = true;
//             // ignore: use_build_context_synchronously
//             Provider.of<List<Task>>(context, listen: false).remove(task); // Update task state
//           }
//         }
//       }
//     },
//   );

//   await Workmanager.schedulePeriodicTask(
//     "check_tasks",
//     Frequency.hourly,
//     const Duration(minutes: 1),
//   ); // Schedule background check on Android (adjust interval)
// }
// FlutterLocalNotificationsPlugin _notificationsPlugin;

// Future<void> scheduleLocalNotification(String message) async {
//   _notificationsPlugin ??= FlutterLocalNotificationsPlugin();

//   const androidNotificationDetails = AndroidNotificationDetails(
//     'alarm_channel',
//     'Task Reminder',
//     'Channel for task completion alarms',
//     importance: Importance.high,
//     priority: Priority.high,
//     sound: RawResourceAndroidNotificationSound('alarm.wav'),
//   );

//   const iosNotificationDetails = IOSNotificationDetails(
//     sound: 'alarm.wav',
//   );

//   final platformChannelSpecifics = NotificationDetails(
//     android: androidNotificationDetails,
//     iOS: iosNotificationDetails,
//   );

//   await _notificationsPlugin.show(0, 'Task Completed!', message, platformChannelSpecifics);
// }
