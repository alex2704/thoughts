import 'package:thoughts/entities/info_user.dart';
import 'package:thoughts/services/api/info_user_api_provider.dart';

class InfoUserRepository {
  final InfoUserProvider _infoUserProvider = InfoUserProvider();
  Future<InfoUser> getCurrentUser(uid) => _infoUserProvider.getUserData(uid);
}