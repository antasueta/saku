import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

    await Future.delayed(Duration(seconds: 1));

    if (email == "admin@test.com" && password == "Admin123") {
    User user = User(
  email: emailController.text,
  name: "User",
);

Navigator.pushReplacementNamed(
  context,
  '/dashboard',
  arguments: user,
);
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
      appBar: AppBar(title: Text("SAKU", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),),
      centerTitle: true),
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [Colors.white, Colors.blue.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
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
                        : Icons.visibility_off,
                        size: 15,),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
                      child: Text("Login", style: TextStyle(color: Colors.white)),
                    ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot');
                },
                child: Text("Lupa Password?", 
                style: TextStyle(decoration: TextDecoration.underline, fontSize: 12),
                ),
              ),

              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: TextStyle(color: Colors.red))
            ],
          ),
        ),
      ),
    ),
    );
  }
}