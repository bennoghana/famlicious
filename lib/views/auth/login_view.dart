import 'package:famlicious/views/auth/createaccount_view.dart';
import 'package:famlicious/views/auth/forgot%20_passwordView.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final emailRegexp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const FlutterLogo(
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
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 8) {
                      return "Password must be more than 8 characters";
                    }
                  }),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordView()));
                  },
                  child: const Text(
                    'Forgot Password? Reset here!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: const Text('Login'),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateAccountsView()));
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
