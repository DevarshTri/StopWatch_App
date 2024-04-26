import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final uname = TextEditingController();
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool login = false;
  String name = '';

  @override
  void dispose() {
    uname.dispose();
    email.dispose();
    super.dispose();
  }
  void validate() {
    final form = formKey.currentState;
    if (form?.validate() ?? false) {
      return;
    }
    setState(() {
      login = true;
      name = uname.text;
      email.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: login ? _buildSucess() : _buildLoginForm(),
      ),
    );
  }

  Widget _buildSucess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check,
          color: Colors.orangeAccent,
        ),
        Text('Hi $name'),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: uname,
            decoration: InputDecoration(
              labelText: "Runner",
            ),
            validator: (text) =>
                text!.isEmpty ? 'Enter Ther runner name' : null,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Enter Email";
                }
                final regex = RegExp('[^@]+@[^.]+.._');
                if (!regex.hasMatch(text)) {
                  return "Enter valid Email";
                }
                return null;
              }),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: validate, child: Text("Continue"))
        ],
      ),
    );
  }
}
