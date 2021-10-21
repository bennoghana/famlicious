import 'package:flutter/material.dart';
import 'package:famlicious/manager/auth_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailRegexp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final TextEditingController _emailController = TextEditingController();
  AuthManager _authManager = AuthManager();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FlutterLogo(
              size: 130,
            ),
            SizedBox(
              height: 35,
            ),
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email is required";
                  }
                  if (!emailRegexp.hasMatch(value)) {
                    return "Email is not valid";
                  }
                }),
            SizedBox(height: 25),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : TextButton(
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty &&
                          emailRegexp.hasMatch(_emailController.text)) {
                        setState(() {
                          isLoading = true;
                        });

                        bool isSent = await _authManager
                            .sendResetLink(_emailController.text);
                        if (isSent) {
                          setState(() {
                            isLoading = false;
                          });

                          Fluttertoast.showToast(
                              msg: "Please check your email for the link",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: _authManager.message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Check Input fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: const Text('Reset Password'),
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .background),
                  ),
          ],
        ),
      )),
    );
  }
}
