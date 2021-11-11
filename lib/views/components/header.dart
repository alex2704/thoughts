import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
        return AppBar(
          centerTitle: true,
          title: const Text(
              'THOUGHTS'
        ));
  }
}