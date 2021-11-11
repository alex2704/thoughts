import 'package:flutter/material.dart';
import 'package:thoughts/views/components/header.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Text('HELLO',
        textAlign: TextAlign.center,)
    );
  }
}