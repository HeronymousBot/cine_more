import 'package:cinemore/provider/FirebaseManager.dart';
import 'package:cinemore/ui/activity/HomeActivity.dart';
import 'package:cinemore/utils/ColorPalette.dart';
import 'package:flutter/material.dart';

class LoginActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginActivityState();
  }
}

class LoginActivityState extends State<LoginActivity> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool hidePassword = true;



  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  validator: (value) {
                    if (!value.contains('@') || value == null) {
                      return 'Please insert a valid email address';
                    }
                  },
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'johndoe@mail.com',
                  ),
                  onFieldSubmitted: (String value){
                    emailFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  focusNode: passwordFocusNode,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Insert a valid password with at least 8 characters.';
                    }
                  },
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: hidePassword
                            ? Colors.grey[800]
                            : ColorPallete.lightColor,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: hidePassword,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: MaterialButton(
          child: Text(
            'Log in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          color: ColorPallete.darkColor,
          height: 48.0,
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            FirebaseManager()
                .handleSignIn(emailController.text, passwordController.text)
                .then(
              (success) {
                if (success) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeActivity()));
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Something went wrong'),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
