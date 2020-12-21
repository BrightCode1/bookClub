import 'package:book_club/src/screens/home/home.dart';
import 'package:book_club/src/screens/login.dart';
import 'package:book_club/src/state/currentUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  LoggedIn,
}

class BookRoot extends StatefulWidget {
  @override
  _BookRootState createState() => _BookRootState();
}

class _BookRootState extends State<BookRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    await Firebase.initializeApp();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == 'success') {
      setState(() {
        _authStatus = AuthStatus.LoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;
      case AuthStatus.LoggedIn:
        retVal = HomeScreen();
        break;
    }

    return retVal;
  }
}
