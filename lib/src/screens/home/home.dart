import 'package:book_club/src/commons/colors.dart';
import 'package:book_club/src/commons/screen_navigation.dart';
import 'package:book_club/src/root/root.dart';
import 'package:book_club/src/state/currentUser.dart';
import 'package:book_club/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Ohms",
          color: primary,
          weight: FontWeight.bold,
          size: 27,
        ),
        centerTitle: true,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: darkPrimary,
            size: 32,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: darkPrimary,
              size: 32,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Sign Out"),
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnString = await _currentUser.onSignOut();
            if (_returnString == "success") {
              changeScreenReplacement(context, BookRoot());
            }
          },
        ),
      ),
    );
  }
}
