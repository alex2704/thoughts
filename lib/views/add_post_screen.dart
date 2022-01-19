import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_bloc.dart';
import 'package:thoughts/bloc/post_bloc/post_event.dart';
import 'package:thoughts/views/components/custom_widgets/orange_elevated_button.dart';

import '../constants.dart';
import '../shared_preferences_util.dart';
import 'components/custom_widgets/custom_input_add_post.dart';
import 'components/footer.dart';
import 'feed_screen.dart';

class AddPostScreen extends StatelessWidget {
  late final String _uid;
  AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    final controller = TextEditingController();
    return FutureBuilder(
        future: SharedPreferencesUtil.getData<String>(Constants.uid)
        .then((value) => _uid = value),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () => {
                                _navigateToFeedPage(context)
                              },
                              child: const Text(
                                "Отменить",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              )),
                          IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 30,
                              )),
                          MyOrangeElevatedButton(
                            onPressed: () => {
                              postBloc.add(CreatePostButtonPressed(userId: _uid, content: controller.text)),
                              _navigateToFeedPage(context)
                            },
                            edgeInsetsGeometry:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: const Text("Опубликовать"),
                            fontSize: 14,
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/no_photo.jpg'),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomInputAddPost(controller: controller)
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  child: Align(alignment: Alignment.bottomCenter, child: Footer()))
            ],
          ),
        ),
      );}
        else {
      return Container();
    }
        });
  }

  void _navigateToFeedPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return FeedScreen();
    }), (Route<dynamic> route) => false);
  }
}
