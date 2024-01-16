// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:developer' as developer;
import 'dart:math';
// import 'dart:isolate';
// import 'dart:ui';

import 'package:alram/service.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

 final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const _AlarmHomePage(),
    );
  }
}

class _AlarmHomePage extends StatefulWidget {
  const _AlarmHomePage({Key? key}) : super(key: key);

  @override
  _AlarmHomePageState createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<_AlarmHomePage> {
  // int _counter = 0;

  @override
  void initState() {
    super.initState();
    AndroidAlarmManager.initialize();

NotificationService.initializeNoti(notificationsPlugin);
   
  }

 
  @pragma('vm:entry-point')
  static  callback({required String name,required String body}) async {
    developer.log('Alarm fired!');
                  NotificationService.showBigTextnoti(name:name, body: body, fln: notificationsPlugin);

  }
Future<DateTime> _chooseDate() async {
    DateTime selectedDateTime = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2023, 7),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDateTime) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }

    developer.log(selectedDateTime.toString());
    return selectedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineMedium;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android alarm manager plus example'),
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'Alarm fired $_counter times',
            //   style: textStyle,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total alarms fired: ',
                  style: textStyle,
                ),
                // Text(
                //   prefs?.getInt(countKey).toString() ?? '',
                //   key: const ValueKey('BackgroundCountText'),
                //   style: textStyle,
                // ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const ValueKey('RegisterOneShotAlarm'),
              onPressed: () async {
              final DateTime chosen= await _chooseDate();
              
                await AndroidAlarmManager.oneShotAt(
                //  DateTime(2023,12,12,22,20),
               chosen,
                  Random().nextInt(pow(2, 31) as int),
              
                  // NotificationService.showBigTextnoti(name:"name", body: "body", fln: notificationsPlugin),

  callback(name: "Called",body: "Hi im Called"),
                
                  exact: true,
                  wakeup: true,
                );
                developer.log("Registor Alram");
              },
              child: const Text(
                'Schedule OneShot Alarm',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
