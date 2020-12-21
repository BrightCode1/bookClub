import 'package:book_club/src/commons/colors.dart';
import 'package:book_club/src/widgets/text.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar(String text) {
    print("Error Here");
    final snackbar = new SnackBar(
      content: CustomText(
        text: text,
        color: white,
        weight: FontWeight.bold,
        size: 18,
      ),
      duration: Duration(seconds: 4),
      backgroundColor: red,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.0,
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
              text: "Forgot Password",
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
              child: GestureDetector(
                onTap: () {
                  bool userEmailValidate = validateEmail(_emailController.text);
                  if (userEmailValidate == false) {
                    _showSnackBar("Invalid Email Address!");
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
                          text: "Receive New Password",
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
          ],
        ),
      ),
    );
  }
}
