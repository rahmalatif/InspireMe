import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final Duration splashDuration = const Duration(seconds: 5);
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer(splashDuration, () {
      _navigateToWelcomeIfStillHere();
    });
  }

  void _navigateToWelcomeIfStillHere() {
    if (!mounted) return;
    final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    if (isCurrent && !_navigated) {
      _navigated = true;
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  void _skipSplash() {
    _timer?.cancel();
    _navigateToWelcomeIfStillHere();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _skipSplash,
      child: Scaffold(
        body: FadeInDownBig(
          child: Center(
            child: SvgPicture.asset(
              "assets/SVG/logo.svg",
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
