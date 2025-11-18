
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inspireme/api_service/quote_service.dart';
import '../localNotifications/local_notification.dart';

class QuoteSchedulerNotification {
  static Future<void> scheduleQuotes() async {
    await LocalNotification.cancelAllNotifications();

    final quotes = await QuoteService().getQuote();

    if (quotes.isEmpty) return;

    final random = Random();
    final now = DateTime.now();

    for (int i = 0; i < 8; i++) {
      final quote = quotes[random.nextInt(quotes.length)];
      final scheduledTime = now.add(Duration(minutes: (i + 1) ));

      await LocalNotification.scheduleNotification(
        id: i,
        title: "InspireMe ✨",
        body: quote.quote,
        hour: scheduledTime.hour,
        minute: scheduledTime.minute,
      );

      print("✅ Scheduled: $quote at ${scheduledTime.hour}:${scheduledTime.minute}");
    }
  }
}
