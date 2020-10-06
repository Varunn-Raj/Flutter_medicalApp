import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
void main() async{
    WidgetsFlutterBinding.ensureInitialized();                               //https://youtu.be/iKxrt4ASR5Y
 var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});     
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }); 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {




  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
void scheduleAlarm() async {
    var scheduledNotificationDateTime=DateTime.now().add(Duration(seconds: 1));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('sound'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'sound.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Reminder',
        'Good morning! Time to take Medicine :)',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
}
    

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Scaffold(appBar: AppBar(title: Text('Notif'),
         color: Colors.green),
    body: RaisedButton(
      onPressed:(){
        scheduleAlarm();

    } ),
    ),
    
    
    
      
    );
  }
}
