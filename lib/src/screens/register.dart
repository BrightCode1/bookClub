import 'package:book_club/src/state/currentUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:book_club/src/commons/colors.dart';
import 'package:book_club/src/commons/screen_navigation.dart';
import 'package:book_club/src/widgets/text.dart';
import 'package:book_club/src/screens/login.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar(String text) {
    final snackbar = new SnackBar(
      content: CustomText(
        text: text,
        color: white,
        weight: FontWeight.bold,
        size: 18,
      ),
      duration: Duration(seconds: 10),
      backgroundColor: red,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context,
      String fullName) async {
    await Firebase.initializeApp();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString =
          await _currentUser.signUpUser(email, password, fullName);
      if (_returnString == "success") {
        Navigator.pop(context);
      } else {
        _showSnackBar(_returnString);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/ohms.png",
                    width: 170,
                    height: 120,
                  ),
                ],
              ),
              CustomText(
                text: "Create Account",
                size: 30,
                weight: FontWeight.bold,
                color: darkPrimary,
              ),
              SizedBox(
                height: 10.0,
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
                      controller: _fullNameController,
                      decoration: InputDecoration(
                          hintText: "Full Name...",
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
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
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: grey[300]),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Confirm Password...",
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
                padding: const EdgeInsets.all(12.0),
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      bool userEmailValidate =
                          validateEmail(_emailController.text);
                      if (_emailController.text.length == 0 ||
                          _fullNameController.text.length == 0 ||
                          _passwordController.text.length == 0) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: CustomText(
                            text: "Fill In All Details!",
                            size: 15,
                            weight: FontWeight.w500,
                            color: white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: red,
                        ));
                      } else if (_fullNameController.text.length <= 4) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: CustomText(
                            text: "Name must be greater than 4 Letters",
                            size: 15,
                            weight: FontWeight.bold,
                            color: white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: red,
                        ));
                      } else if (userEmailValidate == false) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: CustomText(
                            text: "Invalid Email Address!",
                            size: 15,
                            weight: FontWeight.bold,
                            color: white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: red,
                        ));
                      } else if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: CustomText(
                            text: "Passwords Do Not Match!",
                            size: 15,
                            weight: FontWeight.bold,
                            color: white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: red,
                        ));
                      } else {
                        _signUpUser(
                            _emailController.text,
                            _passwordController.text,
                            context,
                            _fullNameController.text);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primary,
                          boxShadow: [
                            BoxShadow(
                                color: primary,
                                offset: Offset(1, 1),
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Sign Up",
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
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GestureDetector(
                  onTap: () {
                    changeScreen(context, LoginScreen());
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Already Have An Account? ",
                          style: TextStyle(
                              color: grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: "Log In",
                          style: TextStyle(
                              color: red,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
