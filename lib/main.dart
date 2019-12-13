
import 'package:cinemore/provider/SessionManager.dart';
import 'package:cinemore/ui/activity/HomeActivity.dart';
import 'package:cinemore/ui/activity/StartActivity.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Application(await SessionManager.read()));
}

class Application extends StatelessWidget {
  bool isUserLogged;
  Application(this.isUserLogged);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinemore',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: isUserLogged ? HomeActivity() : StartActivity(),
      debugShowCheckedModeBanner: false,
    );
  }
}