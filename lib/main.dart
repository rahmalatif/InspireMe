import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inspireme/Views/Home.dart';
import 'package:inspireme/Views/Profile.dart';
import 'package:inspireme/Views/favourite.dart';
import 'package:inspireme/Views/feeling.dart';
import 'package:inspireme/Views/improvment.dart';
import 'package:inspireme/Views/login.dart';
import 'package:inspireme/Views/mainScaffold.dart';
import 'package:inspireme/Views/name.dart';
import 'package:inspireme/Views/signIn.dart';
import 'package:inspireme/Views/splash.dart';
import 'package:inspireme/Views/welcome.dart';
import 'package:inspireme/services/auth.dart';
import 'Views/notification.dart';
import 'core/Design/Bottom_Nav_Bar.dart';
import 'firebase_options.dart';
import 'localNotifications/local_notification.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Local notifications init
  await LocalNotification.init();
  LocalNotification.requestNotificationPermission();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initState(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('========================================User is currently signed out!');
      } else {
        print('========================================User is signed in!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashView(),
        '/auth':(context)=>Auth(),
        '/welcome': (context) => const WelcomeView(),
        '/login': (context) => const LoginView(),
        '/signin': (context) => const SigninView(),
        '/name': (context) => const NameView(),
        '/feeling': (context) => const FeelingView(),
        '/improve': (context) => const ImprovmentView(),
        '/fav': (context) => const FavouriteView(),
        '/main': (context) => const MainScaffold(),
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      initialRoute: '/auth',
    );
  }
}
