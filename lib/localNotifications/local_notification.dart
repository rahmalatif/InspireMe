import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inspireme/api_service/quote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class LocalNotification {
  // Plugin instance
  static final FlutterLocalNotificationsPlugin notificationPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize notifications
  static Future<void> init() async {
    // Android settings
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialization settings
    const InitializationSettings initSettings =
    InitializationSettings(android: androidInitSettings);

    // Initialize the plugin
    await notificationPlugin.initialize(initSettings);

    // Initialize timezone
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  // ✅ Notification details
  static NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id', // channel id
        'Daily Notifications', // channel name
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  //  Show instant notification
  static Future<void> showInstantNotification({
    int id = 0,
    String title = "InspireMe ✨",
  }) async {
    final quotes = await QuoteService().getQuote();
    final quoteText = quotes.isNotEmpty ? quotes.first.quote : "Stay motivated!";

    await notificationPlugin.show(
      id,
      title,
      quoteText,
      notificationDetails(),
    );

    print("✅ Instant notification shown: $quoteText");
  }


  // ✅ Request notification permission
  static Future<void> requestNotificationPermission() async {
    final androidImplementation = notificationPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
  }

  // ✅ Schedule notification at specific time (daily)
  static Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final isDaily = prefs.getBool("isDailyQuote") ?? true;

    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If the time already passed today, schedule it for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("⏰ Scheduled: $body at $hour:$minute");
  }

  // ✅ Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await notificationPlugin.cancelAll();
  }
}
