import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thoughts/entities/info_user.dart';

class InfoUserProvider {
  FirebaseFirestore? _instance;

  Future createUserData(String uid, String login, String name) async {
    _instance = FirebaseFirestore.instance;
    return await _instance!
        .collection("users")
        .doc(uid)
        .set({
      'uid': uid,
      'login': login,
      'name': name,
      'description': '',
      'posts_count': 0,
      'id_avatar': 0,
      'followers_count': 0,
      'following_count': 0
    });
  }

  Future<InfoUser> getUserData(String uid) async {
    _instance = FirebaseFirestore.instance;
    DocumentReference user = _instance!.doc("users/$uid");
    DocumentSnapshot userSnapshot = await user.get();
    var userData = userSnapshot.data() as dynamic;
    var infoUser = InfoUser.fromJson(userData);
    return infoUser;
  }
}