import 'package:equatable/equatable.dart';

class InfoUser extends Equatable {

  final String uid;
  final String login;
  late final String description;
  final String name;
  late final int idAvatar;
  late final int followersCount;
  late final int followingCount;
  late final int postsCount;

  InfoUser({required this.uid, required this.login, required this.name}) {
    description = "";
    idAvatar = 0;
    followersCount = 0;
    followingCount = 0;
    postsCount = 0;
  }

  InfoUser.fullUser({required this.uid,
    required this.login, required this.name,
    required this.description, required this.idAvatar,
    required this.followersCount, required this.followingCount,
    required this.postsCount});

  InfoUser.partInfoUser({
    required this.uid,
    required this.name,
    required this.login,
    required this.idAvatar
});

  @override
  List<Object?> get props =>
      [uid, login, description, name, idAvatar, followersCount,
        followingCount, postsCount];

  factory InfoUser.fromJson(Map<String, dynamic> json) {
    return InfoUser.fullUser(
        uid: json['uid'],
        login: json['login'],
        name: json['name'],
        description: json['description'],
        idAvatar: json['id_avatar'],
        followersCount: json['followers_count'],
        followingCount: json['following_count'],
        postsCount: json['posts_count']);
  }

  factory InfoUser.fromJsonPart(Map<String, dynamic> json) {
    return InfoUser.partInfoUser(
      uid: json['uid'],
      login: json['login'],
      name: json['name'],
      idAvatar: json['id_avatar']
    );
  }

}