import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
        children: const [
            Text('another_user',
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Really cool'
            )]),
            const Text('вчера',
            style: TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
              fontSize: 12
            ),)
          ]
        ));
  }
}