import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';

class CustomInputAddPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputAddPostState();
  }
}

class _InputAddPostState extends State<CustomInputAddPost> {

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width- 120,
            child: TextField(
              keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 25,
              controller: controller,
                autofocus: true,
              style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: false,
                  hintText: "Поделись мыслями",
                  hintStyle: const TextStyle(color: CustomColors.grey),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
            ),
          )
        ],
      ),
    );
  }
}