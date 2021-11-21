import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';

import 'components/custom_widgets/custom_textfield.dart';
import 'components/custom_widgets/grey_elevated_button.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: SingleChildScrollView(
          child: Padding(
              padding:
              const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Center(
                    child: Text('Регистрация',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline1),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          'Заполните указанные поля',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )),
                  CustomTextField.textField(context, 'Логин',
                      length: 30, cornerRadius: 10.0),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Ваше имя',
                      length: 30, cornerRadius: 10.0),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Пароль',
                      length: 30, cornerRadius: 10.0, isPassword: true),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Повторите пароль',
                      length: 30, cornerRadius: 10.0, isPassword: true),
                  const SizedBox(
                      height: 70),
                  MyGreyElevatedButton(child: const Text(
                    'Регистрация', style: TextStyle(color: Colors.white),),
                      onPressed: () =>
                      {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/feed', (r) => false)
                      }),
                  const SizedBox(height: 20),
                  RichText(text:
                  TextSpan(
                      children: [
                        const TextSpan(text: 'Уже есть аккаунт? ',
                            style: TextStyle(color: Colors.white)),
                        TextSpan(text: 'Войти в аккаунт',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/login', (r) => false);
                              }
                        )
                      ]))
                ],
              ))),
    );
  }
}