import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remind/screen/startgate_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      _navigateToGate();
    });
  }
  void _navigateToGate (){
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => StartgateScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _Logo(),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child:   Image.asset('assets/img/logo.png', width: 270,height: 270,),
    );
  }
}