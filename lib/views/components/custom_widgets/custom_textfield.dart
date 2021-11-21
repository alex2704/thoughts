import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField {
  static Widget textField(BuildContext context, String title,
      {bool isPassword = false, isNumber = false, required length,
        TextEditingController? textController, lines = 1, var cornerRadius = 0.0}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Lato'),
            ),
            const SizedBox(
              height: 2,
            ),
            TextFormField(
              maxLines: lines,
              controller: textController,
              maxLength: length,
              inputFormatters: [
                LengthLimitingTextInputFormatter(length),
              ],
              obscureText: isPassword,
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: cornerRadius == 0
                    ? InputBorder.none
                    : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(cornerRadius),
                ),
                fillColor: const Color(0xffffffff),
                filled: true,
              ),
            )
          ],
        ));
  }
}
