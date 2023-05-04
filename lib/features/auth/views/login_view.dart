
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/extension.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/views/signup_view.dart';
import 'package:twitter_clone/theme/pallete.dart';
import '../../../common/loading_page.dart';
import '../../../core/providers.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';


class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController=TextEditingController();
  final passController=TextEditingController();
  final appBar=UIConstants.appBar();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void onLogin() async{

    ref.read(authControllerProvider.notifier).login(
      email: emailController.text,
      pass: passController.text,
      context: context,
    );

  }

  @override
  Widget build(BuildContext context) {

    final  bool isLoading= ref.watch(authControllerProvider);
    return isLoading? const Loader(): Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                children:[
                  AuthField(
                    controller: emailController,
                    labelText: "Email",
                  ),
                  const SizedBox(height: 25,),
                  AuthField(
                    controller: passController,
                    labelText: "Password",
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: const Text('Forgot password?',
                          style: TextStyle(fontSize: 16,color: Pallete.blueColor),
                        ),
                      ),
                      RoundedSmallButton(
                        label: 'Done',
                        onTap: onLogin,

                      ),


                    ],
                  ),
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign up',
                          style: const TextStyle(
                            color: Pallete.blueColor,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement(const SignUpView());
                            },
                        ),
                      ],
                    ),
                  ),
                ]

            ),
          ),
        ),
      ),
    );
  }
}

