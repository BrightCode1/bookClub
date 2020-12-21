import 'package:book_club/src/commons/colors.dart';
import 'package:book_club/src/commons/screen_navigation.dart';
import 'package:book_club/src/screens/forgot.dart';
import 'package:book_club/src/screens/home/home.dart';
import 'package:book_club/src/screens/register.dart';
import 'package:book_club/src/state/currentUser.dart';
import 'package:book_club/src/widgets/text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginType {
  email,
  google,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar(String text) {
    final snackBar = new SnackBar(
      content: CustomText(
        text: text,
        color: white,
        weight: FontWeight.bold,
        size: 17,
      ),
      duration: Duration(seconds: 4),
      backgroundColor: red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _loginUser(
      {@required LoginType type,
      String email,
      String password,
      BuildContext context}) async {
    await Firebase.initializeApp();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString;

      switch (type) {
        case LoginType.email:
          _returnString =
              await _currentUser.loginUserWithEmail(email, password);
          break;
        case LoginType.google:
          _returnString = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == 'success') {
        changeScreenReplacement(context, HomeScreen());
      } else {
        _showSnackBar(_returnString);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _googleButton() {
    return OutlineButton(
        onPressed: () {
          _loginUser(type: LoginType.google, context: context);
        },
        splashColor: grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        highlightElevation: 0,
        borderSide: BorderSide(color: grey),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/google.png"),
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: "Sign In With Google",
                  color: grey,
                  size: 18,
                  weight: FontWeight.w500,
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/ohms.png",
                  width: 170,
                  height: 170,
                ),
              ],
            ),
            CustomText(
              text: "Welcome Back",
              size: 30,
              weight: FontWeight.bold,
              color: darkPrimary,
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey[300]),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email Address...",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: grey,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey[300]),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password...",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: grey,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, ForgotPassword());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "Forgot Password?",
                      color: primary,
                      size: 17,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  bool userEmailValidate = validateEmail(_emailController.text);
                  if (_emailController.text.length == 0 ||
                      _passwordController.text.length == 0) {
                    _showSnackBar("Fill In All Details!");
                  } else if (userEmailValidate == false) {
                    _showSnackBar("Invalid Email Address!");
                  } else {
                    _loginUser(
                        type: LoginType.email,
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primary,
                      boxShadow: [
                        BoxShadow(
                            color: primary, offset: Offset(1, 1), blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Log In",
                          size: 20,
                          color: white,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 0),
              child: Container(
                child: CustomText(
                  text: "OR",
                  color: grey,
                  size: 18,
                  weight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //       border: Border.all(color: grey[100]),
                //       borderRadius: BorderRadius.circular(200)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(5.0),
                //     child: CircleAvatar(
                //       backgroundImage: AssetImage("assets/images/google.png"),
                //       backgroundColor: Colors.transparent,
                //     ),
                //   ),
                // ),
                _googleButton()
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, RegistrationScreen());
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "New Here? ",
                        style: TextStyle(
                            color: grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                            color: red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
