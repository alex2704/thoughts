import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/bloc/post_bloc/post_state.dart';
import 'package:thoughts/constants.dart';
import 'package:thoughts/entities/info_user.dart';
import 'package:thoughts/repositories/post_repository.dart';
import 'package:thoughts/shared_preferences_util.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/components/header.dart';

import 'components/custom_widgets/orange_elevated_button.dart';
import 'components/feed_item.dart';
import 'components/feed_items_list.dart';
import 'components/footer.dart';


class ProfileScreen extends StatelessWidget {
  final InfoUser infoUser;
  late final String _uid;

  ProfileScreen({required this.infoUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(PostLoadForProfileEvent(userId: infoUser.uid));
    return Scaffold(
      appBar: Header(),
      body: FutureBuilder(
        future: SharedPreferencesUtil.getData<String>(Constants.uid)
          .then((value) => _uid = value),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          return BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostEmptyState) {
                return const Center(
                  child: Text('Ошибка. Не удалось загрузить данные'),
                );
              }

              if (state is PostLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PostLoadedState) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          infoUser.idAvatar == 0 ?
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 20, top: 20, right: 20),
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/images/no_photo.jpg'),
                              radius: 50,
                            ),
                          )
                              : Container(),
                          Expanded(
                            child: Text(
                              infoUser.description, style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Text(infoUser.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600
                                  ),),
                                Text(infoUser.login,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container()),
                          infoUser.uid == _uid ?
                          MyOrangeElevatedButton(
                            onPressed: () => {},
                            edgeInsetsGeometry:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child:
                            const Text("Редактировать"),
                            fontSize: 14,
                          ) :
                          MyOrangeElevatedButton(
                            onPressed: () => {},
                            edgeInsetsGeometry:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child:
                            const Text("Подписаться"),
                            fontSize: 14,
                          ),
                        ],
                      ),
                      // numbers of posts, subs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 3,
                            child: Column(
                              children: [
                                Text(
                                  infoUser.postsCount.toString(),
                                  style:
                                  const TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Посты',
                                  style:
                                  TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 3,
                            child: Column(
                              children: const [
                                Text('62',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text('Подписчики',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 3 - 20,
                            child: Column(
                              children: const [
                                Text('35',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text('Подписки',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          color: CustomColors.grey,
                          height: 10,
                        ),
                      ),
                          Expanded(child:
                          Stack(children: <Widget>[
                            ListView.builder(
                                itemCount: state.loadedForProfile.length,
                                itemBuilder: (context, index) => FeedItem(
                                  post: state.loadedForProfile[index],
                                  fromProfile: true,
                                )),
                                Positioned(
                                    child: Align(
                                        alignment: Alignment.bottomCenter, child: Footer()))
                          ]))
                    ],
                  ),
                );
              }
              return const Center(child: Text('Произошла ошибка'));
            }
          );
          } else {
            return Container();
          }
        }
      )
    );
  }
}