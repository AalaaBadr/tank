import 'package:flutter/material.dart';
import 'Signup_page.dart';
import 'Login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //       backgroundColor: Colors.red,
        //       title: const Center(
        //           child: Text(
        //         'Control Page',
        //         style: TextStyle(fontSize: 40),
        //       )),
        //     ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 241, 93, 82),
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(200)),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.red,
                            Colors.red,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Center(
                          child: Text('Log in',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.red,
                            Colors.red,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Center(
                            child: Text('Sign up',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          )),
                    ),
                  ]),
            )));
  }
}
