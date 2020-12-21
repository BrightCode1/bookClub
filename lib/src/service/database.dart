import 'package:book_club/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = 'error';

    try {
      await _firestore.collection("users").doc(user.uid).set({
        "fullName": user.fullName,
        "email": user.email,
        "accountCreated": Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
  }
}
