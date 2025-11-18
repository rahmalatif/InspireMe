import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future navigateTo(Widget page) async {
  final context = navigatorKey.currentContext;
  if (context != null) {
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  } else {
    throw Exception('Navigator context is null');
  }
}


void showMessage(String message, {bool isSuccess = false}){
  if(message.isNotEmpty){
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess?Colors.green : Colors.red,
      ),
    );
  }
}

