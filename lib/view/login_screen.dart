import 'package:flutter/material.dart';
import 'package:zoft_care/controller/repo/auth_repo.dart';
import 'package:zoft_care/view/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: "");

  TextEditingController passwordController = TextEditingController(text: "");
  bool isLoading = false;
  String errorMessage = "";
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Form(
            key: loginKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple.shade300),
                          ),
                          labelStyle:
                              const TextStyle(color: Colors.deepPurple)),
                      validator: (value) {
                        if (value!.contains("@") == false) {
                          return 'Please valid email id';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                      controller: passwordController,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple.shade300),
                          ),
                          labelStyle:
                              const TextStyle(color: Colors.deepPurple)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (loginKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                errorMessage = '';
                              });
                              final res = await AuthRepo().userLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (res.contains("Error")) {
                                setState(() {
                                  errorMessage =
                                      "Email and password not matching!";
                                  isLoading = false;
                                });
                              } else {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                    title: "Home Page",
                                  ),
                                ));
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: const Text("Log in")),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )));
  }
}
