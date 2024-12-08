import 'package:flutter/material.dart';
import 'package:r8_it/components/my_button.dart';
import 'package:r8_it/components/my_loading_circle.dart';
import 'package:r8_it/components/my_text_field.dart';
import 'package:r8_it/sevices/auth/auth_serviec.dart';
import 'package:r8_it/sevices/database/database_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? OnTap;
  const RegisterPage({super.key, required this.OnTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthServiec();
  final _db = DatabaseService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmpwController = TextEditingController();
  void register() async {
    if (pwController.text == confirmpwController.text) {
      showLoadingCircle(context);
      try {
        await _auth.registerEmailPassword(
            emailController.text, pwController.text);

        if (mounted) hideLoadingCircle(context);

        await _db.saveUserInfoInFirebase(
            name: nameController.text, email: emailController.text);
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
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Passwords Dont Match"),
              ));
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
                "assets/img/logo.png",
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Let's Create An Account",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              const SizedBox(height: 30),
              MyTextField(
                  controller: nameController,
                  hintText: " Enter name ",
                  obscureText: false),
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: confirmpwController,
                  hintText: " Confirm Password.. ",
                  obscureText: true),
              const SizedBox(
                height: 10,
              ),
              MyButton(text: "Register", onTap: register),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member ?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                      onTap: widget.OnTap,
                      child: Text(
                        "  Login now",
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
