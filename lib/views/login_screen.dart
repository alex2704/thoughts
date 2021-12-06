import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thoughts/bloc/login_bloc/login_bloc.dart';
import 'package:thoughts/bloc/login_bloc/login_event.dart';
import 'package:thoughts/bloc/login_bloc/login_state.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/components/custom_widgets/custom_textfield.dart';
import 'package:thoughts/views/components/custom_widgets/grey_elevated_button.dart';
import 'package:thoughts/views/registration_screen.dart';

import 'feed_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
    child: LoginScreenChild());
  }
}


class LoginScreenChild extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  LoginScreenChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.only(top: 160.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginInitialState) {
                        _buildInitialUi();
                      } else if (state is LoginFailureState) {
                        _buildFailureUi(state.message);
                      } else if (state is LoginSuccessState) {
                        _navigateToFeedPage(context, state.user);
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return _buildLoadingUi();
                      }
                      return Container();
                    }),
                  ),
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
                      length: 30,
                      cornerRadius: 10.0,
                      textController: emailController),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Пароль',
                      length: 30,
                      cornerRadius: 10.0,
                      isPassword: true,
                      textController: passwordController),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                  ),
                  MyGreyElevatedButton(
                      child: const Text(
                        'Войти',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => {
                            _loginBloc.add(LoginButtonPressedEvent(
                                email: emailController.text,
                                password: passwordController.text))
                          }),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: 'Нет аккаунта? ',
                        style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text: 'Создать аккаунт',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _navigateToRegisterPage(context);
                          })
                  ]))
                ],
              ))),
    );
  }

  void _buildInitialUi() {
    Fluttertoast.showToast(
        msg: "Enter login credentials",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildLoadingUi() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _buildFailureUi(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _navigateToFeedPage(BuildContext context, User? user) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return FeedScreen();
    }), (Route<dynamic> route) => false);
  }

  void _navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const RegistrationScreen();
    }));
  }
}
