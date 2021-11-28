import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  late String id;

  AppUser.fromFirebase(User user){
    id = user.uid;
  }
}