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
  String avatarUrl;

  InfoUser({required this.uid, required this.login, required this.name, required this.avatarUrl}) {
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
    required this.postsCount,
  required this.avatarUrl});

  InfoUser.partInfoUser({
    required this.uid,
    required this.name,
    required this.login,
    required this.idAvatar,
    required this.avatarUrl
});

  @override
  List<Object?> get props =>
      [uid, login, description, name, idAvatar, followersCount,
        followingCount, postsCount, avatarUrl];

  factory InfoUser.fromJson(Map<String, dynamic> json) {
    return InfoUser.fullUser(
        uid: json['uid'],
        login: json['login'],
        name: json['name'],
        description: json['description'],
        idAvatar: json['id_avatar'],
        followersCount: json['followers_count'],
        followingCount: json['following_count'],
        postsCount: json['posts_count'],
        avatarUrl: json['avatar_url']);
  }

  factory InfoUser.fromJsonPart(Map<String, dynamic> json) {
    return InfoUser.partInfoUser(
      uid: json['uid'],
      login: json['login'],
      name: json['name'],
      idAvatar: json['id_avatar'],
      avatarUrl: json['avatar_url']
    );
  }

}