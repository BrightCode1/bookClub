import 'package:book_club/src/commons/colors.dart';
import 'package:book_club/src/root/root.dart';
import 'package:book_club/src/state/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ohms',
        theme: ThemeData(
          primarySwatch: blue,
        ),
        home: BookRoot(),
      ),
    );
  }
}
