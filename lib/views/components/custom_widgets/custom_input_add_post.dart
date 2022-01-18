import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';

class CustomInputAddPost extends StatefulWidget {
  final TextEditingController controller;
  const CustomInputAddPost({required this.controller});

  @override
  State<StatefulWidget> createState() {
    return _InputAddPostState();
  }
}

class _InputAddPostState extends State<CustomInputAddPost> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
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
              controller: widget.controller,
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