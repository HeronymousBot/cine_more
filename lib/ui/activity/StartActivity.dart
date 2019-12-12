
import 'package:cinemore/ui/activity/LoginActivity.dart';
import 'package:cinemore/ui/activity/SignupActivity.dart';
import 'package:cinemore/utils/ColorPalette.dart';
import 'package:flutter/material.dart';

class StartActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: MaterialButton(
                  height: 48,
                  minWidth: MediaQuery.of(context).size.width,
                  color: ColorPallete.darkColor,
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginActivity()));
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 48,
                  color: ColorPallete.lightColor,
                  child: Text(
                    'Create account',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupActivity()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
