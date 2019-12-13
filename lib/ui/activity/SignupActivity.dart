import 'package:cinemore/provider/FirebaseManager.dart';
import 'package:cinemore/ui/activity/HomeActivity.dart';
import 'package:cinemore/utils/ColorPalette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupActivityState();
  }
}

class SignupActivityState extends State<SignupActivity> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
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
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: userNameController,
                  focusNode: userNameFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please insert your name';
                    }
                  },
                  onFieldSubmitted: (String value){
                    userNameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'John Doe',
                  ),
                ),
                TextFormField(
                  focusNode: emailFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!value.contains('@') || value == null) {
                      return 'Please insert a valid email address';
                    }
                  },
                  onFieldSubmitted: (value){
                    emailFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'johndoe@mail.com',
                  ),
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
            'Sign up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          color: ColorPallete.darkColor,
          height: 48.0,
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              FirebaseManager()
                  .createUser(emailController.text, passwordController.text,
                      userNameController.text)
                  .then((success) {
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
              });
            }
          },
        ),
      ),
    );
  }
}
