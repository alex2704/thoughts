import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/views/components/custom_widgets/orange_elevated_button.dart';

import 'components/custom_widgets/custom_input_add_post.dart';
import 'components/footer.dart';
import 'feed_screen.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () => {},
                          edgeInsetsGeometry:
                              EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Опубликовать"),
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
                      CustomInputAddPost()
                    ],
                  )
                ],
              ),
            ),
            const Positioned(
                child: Align(alignment: Alignment.bottomCenter, child: Footer()))
          ],
        ),
      ),
    );
  }

  void _navigateToFeedPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
