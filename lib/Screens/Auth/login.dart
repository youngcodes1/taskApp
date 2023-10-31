import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Screens/Auth/signup.dart';

import '../../Provider/user_provider.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 100,
            child: const Center(
                child: Text(
              'Welcome Back',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Baloo2'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.login_rounded,
                              size: 35,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.email),
                          controller: email,
                          labelText: 'Email',
                          suffixIcon: TextButton(
                              onPressed: () {
                                email.clear();
                              },
                              child: const Icon(Icons.cancel)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.lock),
                          controller: password,
                          labelText: 'password',
                          isPassword: true,
                          suffixIcon: TextButton(
                              onPressed: () {
                                password.clear();
                              },
                              child: const Icon(Icons.cancel)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          label: 'Login',
                          loading: userprovider.loading,
                          onPressed: userprovider.loading
                              ? () {}
                              : () async {
                                  if (_formkey.currentState!.validate()) {
                                    await userprovider.loginUser(
                                        email.text, password.text);
                                  }
                                },
                          color: Colors.purple,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Dont have an account?',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(const SignUpScreen());
                                },
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 16),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
