import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:thoughts/constants.dart';
import 'package:thoughts/entities/info_user.dart';
import 'package:thoughts/shared_preferences_util.dart';

class InfoUserProvider {
  FirebaseFirestore? _instance;
  FirebaseStorage? _firebaseStorage;

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
      'following_count': 0,
      'avatar_url': ""
    });
  }

  Future<InfoUser> getUserDataWithoutUid() async {
    String uid = await SharedPreferencesUtil.getData<String>(Constants.uid);
    return getUserData(uid);
}

  Future<InfoUser> getUserData(String uid) async {
    _instance = FirebaseFirestore.instance;
    DocumentReference user = _instance!.doc("users/$uid");
    DocumentSnapshot userSnapshot = await user.get();
    var userData = userSnapshot.data() as dynamic;
    var infoUser = InfoUser.fromJson(userData);
    if (infoUser.avatarUrl != "") {
      String fullUrl = await getUrlImage(infoUser.avatarUrl);
      infoUser.avatarUrl = fullUrl;
    }
    return infoUser;
  }

  Future<String> getUrlImage(String path) async{
    _firebaseStorage = FirebaseStorage.instance;
    final ref = _firebaseStorage!.ref().child(path);
    var url = await ref.getDownloadURL();
    return url;
  }
}