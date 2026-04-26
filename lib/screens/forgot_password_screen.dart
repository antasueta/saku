import 'package:flutter/material.dart';
import '../utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  bool isLoading = false;

  void sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Link reset telah dikirim ke email")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lupa Password")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      validator: Validators.validateEmail,
                      onChanged: (value) => email = value,
                    ),
                    SizedBox(height: 20),

                    isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: sendResetLink,
                            child: Text("Kirim Link Reset"),
                          ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kembali ke Login"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}