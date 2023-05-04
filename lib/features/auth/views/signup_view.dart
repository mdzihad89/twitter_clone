
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/extension.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import '../../../common/loading_page.dart';
import '../../../common/rounded_small_button.dart';
import '../../../constants/ui_constants.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_field.dart';


class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final appBar = UIConstants.appBar();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void onSignUp() async{
     ref.read(authControllerProvider.notifier).signUp(
      email: emailController.text.toString(),
      pass: passController.text,
      name: nameController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
  final  bool isLoading= ref.watch(authControllerProvider);

    return  Scaffold(
      appBar: appBar,
      body: isLoading? const Loader(): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              AuthField(
                controller: nameController,
                labelText: "Name",
              ),
              const SizedBox(
                height: 25,
              ),
              AuthField(
                controller: emailController,
                labelText: "Email",
              ),
              const SizedBox(
                height: 25,
              ),
              AuthField(
                controller: passController,
                labelText: "Password",
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RoundedSmallButton(
                  label: 'Done',
                  onTap: onSignUp,
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: "Already have an account?",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' Sign in',
                      style: const TextStyle(
                        color: Pallete.blueColor,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushReplacement(const LoginView());
                        },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
