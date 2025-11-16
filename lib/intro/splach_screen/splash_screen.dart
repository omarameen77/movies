import 'package:flutter/material.dart';
import 'package:movies/intro/onpoarding_screens/export_app.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
static const String routeName=" /splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
 void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.pushReplacementNamed((context), ExportApp.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

         Image.asset("assets/images/splash.png"),
       ],)
      ],
    );
  }
}