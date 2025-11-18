
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inspireme/Views/Home.dart';
import 'package:inspireme/Views/Profile.dart';
import 'package:inspireme/Views/favourite.dart';
import 'package:inspireme/Views/feeling.dart';
import 'package:inspireme/Views/improvment.dart';
import 'package:inspireme/Views/mainScaffold.dart';
import 'package:inspireme/Views/name.dart';
import 'package:inspireme/Views/splash.dart';
import 'Views/notification.dart';
import 'core/Design/Bottom_Nav_Bar.dart';
import 'firebase_options.dart';
import 'localNotifications/local_notification.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FCM
  //await FirebaseNotification().initNotifications();
  //Local
  await  LocalNotification.init();
LocalNotification.requestNotificationPermission();
    runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/'   : (context) => const SplashView(),
          '/name': (context) => NameView(),
          '/feeling':(context)=>FeelingView(),
          '/improve':(context)=>ImprovmentView(),
          '/fav': (context) => FavouriteView(),
          '/main': (context) => MainScaffold(),
        },
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      initialRoute: '/'
    );
  }
}
