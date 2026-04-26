import 'package:flutter/material.dart';
import '../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool isLoading = false;
  bool isPasswordVisible = false;
  String errorMessage = '';

  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    await Future.delayed(Duration(seconds: 2));

    if (email == "admin@test.com" && password == "Admin123") {
      Navigator.pushReplacementNamed(context, '/dashboard',
          arguments: email);
    } else {
      setState(() {
        errorMessage = "Login gagal!";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: Validators.validateEmail,
                onChanged: (value) => email = value,
              ),
              TextFormField(
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: Validators.validatePassword,
                onChanged: (value) => password = value,
              ),
              SizedBox(height: 20),

              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: login,
                      child: Text("Login"),
                    ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot');
                },
                child: Text("Lupa Password?"),
              ),

              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: TextStyle(color: Colors.red))
            ],
          ),
        ),
      ),
    );
  }
}