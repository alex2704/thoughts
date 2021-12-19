import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thoughts/bloc/auth_bloc/auth_bloc.dart';
import 'package:thoughts/bloc/auth_bloc/auth_event.dart';
import 'package:thoughts/bloc/reg_bloc/reg_bloc.dart';
import 'package:thoughts/bloc/reg_bloc/reg_event.dart';
import 'package:thoughts/bloc/reg_bloc/reg_state.dart';
import 'package:thoughts/constants.dart';
import 'package:thoughts/shared_preferences_util.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/feed_screen.dart';
import 'package:thoughts/views/login_screen.dart';

import 'components/custom_widgets/custom_textfield.dart';
import 'components/custom_widgets/grey_elevated_button.dart';


class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegBloc(),
        child: RegistrationScreenChild());
  }
}

class RegistrationScreenChild extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  late RegBloc _regBloc;
  late AuthBloc _authBloc;

  RegistrationScreenChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _regBloc = BlocProvider.of<RegBloc>(context);
    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  BlocListener<RegBloc, RegState>(
                    listener: (context, state) {
                      if (state is RegInitialState) {
                        _buildInitialUi();
                      } else if (state is RegFailureState) {
                        _buildFailureUi(state.msg);
                      } else if (state is RegSuccessfulState) {
                        _authBloc.add(UserSignedInEvent());
                        SharedPreferencesUtil.saveData<String>(Constants.uid, state.user!.uid);
                        _navigateToFeedPage(context, state.user);
                      }
                    },
                    child: BlocBuilder<RegBloc, RegState>(
                        builder: (context, state) {
                          if (state is RegLoadingState) {
                            return _buildLoadingUi();
                          }
                          return Container();
                        }),
                  ),
                  Center(
                    child: Text('Регистрация',
                        style: Theme.of(context).textTheme.headline1),
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
                      length: 30,
                      cornerRadius: 10.0,
                      textController: emailController),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Ваше имя',
                      length: 30,
                      cornerRadius: 10.0,
                      textController: nameController),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Пароль',
                      length: 30,
                      cornerRadius: 10.0,
                      isPassword: true,
                      textController: passwordController),
                  const SizedBox(height: 10),
                  CustomTextField.textField(context, 'Повторите пароль',
                      length: 30,
                      cornerRadius: 10.0,
                      isPassword: true,
                      textController: repeatPasswordController),
                  SizedBox(height: MediaQuery.of(context).size.height / 10,),
                  MyGreyElevatedButton(
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => {
                            _regBloc.add(SignUpButtonPressedEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text)),

                          }),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: 'Уже есть аккаунт? ',
                        style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text: 'Войти в аккаунт',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _navigateToLoginPage(context);
                          })
                  ]))
                ],
              ))),
    );
  }

  void _buildInitialUi() {
    Fluttertoast.showToast(
        msg: "Enter your data",
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

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

}
