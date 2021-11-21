import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/components/custom_widgets/custom_textfield.dart';
import 'package:thoughts/views/components/custom_widgets/grey_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.only(top: 160.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Center(
                    child: Text('Войти в аккаунт',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          'Введите свои учетные данные',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )),
                  CustomTextField.textField(context, 'Логин',
                      length: 30, cornerRadius: 10.0),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Пароль',
                      length: 30, cornerRadius: 10.0, isPassword: true),
                  const SizedBox(
                      height: 140),
                  MyGreyElevatedButton(child: const Text('Войти', style: TextStyle(color: Colors.white),), onPressed: () => {
                      Navigator.of(context).pushNamedAndRemoveUntil('/feed', (r) => false)
                  }),
                  const SizedBox(height: 20),
                  RichText(text:
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Нет аккаунта? ',
                      style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'Создать аккаунт',
                    style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/feed', (r) => false);
                        }
                  )]))
                ],
              ))),
    );
  }
}
