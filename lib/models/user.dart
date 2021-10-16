import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PASSWORD = "password";
  static const PHONENO = "phoneNumber";
  static const USERNAME = "username";

  String uid;
  String name;
  String email;
  String phoneNumber;
  String password;
  String username;

  UserData({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.username,
  });

  UserData.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    uid = snapshot.data()[ID];
    password = snapshot.data()[PASSWORD];
    phoneNumber = snapshot.data()[PHONENO];
    username = snapshot.data()[USERNAME];
  }
}
