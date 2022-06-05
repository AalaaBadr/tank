import 'package:firebase_database/firebase_database.dart';
import 'CamPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String validValue = '';
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white10,
                Colors.white,
              ],
            ),
          ),
          child: Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.contains('@') && value.contains('.')) {
                              validValue = 'Ok';
                            } else {
                              return 'Invalid email:Your email should contain @ and .com';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'email',
                            hintStyle: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          textAlign: TextAlign.start,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) {},
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Invalid password';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: () async {
                              final message = await signup();
                              if (formKey.currentState!.validate()) {
                                if (message != 'Ok') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CamPage()));
                                }
                              }
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]))),
        ));
  }

  Future<String> signup() async {
    try {
      FirebaseDatabase firebase = FirebaseDatabase.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      return 'Ok';
    } on FirebaseAuthException catch (e) {
      print(e);
      var errorMessage = 'Authentication failed';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'email-already-in-use') {
        print('email already exists.');
        errorMessage = 'email already exists.';
      }
      return errorMessage;
    }
  }
}
