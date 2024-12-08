import 'package:flutter/material.dart';
import 'package:r8_it/components/my_button.dart';
import 'package:r8_it/components/my_loading_circle.dart';
import 'package:r8_it/components/my_text_field.dart';
import 'package:r8_it/sevices/auth/auth_serviec.dart';

class LoginPage extends StatefulWidget {
  final void Function()? OnTap;
  const LoginPage({super.key, required this.OnTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthServiec();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void login() async {
    showLoadingCircle(context);
    try {
      await _auth.loginEmailPassword(emailController.text, pwController.text);
      // ignore: use_build_context_synchronously
      hideLoadingCircle(context);
    } catch (e) {
      if (mounted) hideLoadingCircle(context);
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/img/loginEmote.png",
                height: 300,
              ),
              MyTextField(
                  controller: emailController,
                  hintText: " Enter Email.. ",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: pwController,
                  hintText: "Enter Password",
                  obscureText: true),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(text: "Login", onTap: login),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a Member ?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                      onTap: widget.OnTap,
                      child: Text(
                        "  Register Now",
                        style: TextStyle(color: Colors.lightBlueAccent),
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
