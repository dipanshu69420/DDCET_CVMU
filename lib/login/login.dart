import 'package:cvmuproject/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cvmuproject/views/home_screen.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/cvmu-logo.png",
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(36, 59, 85, 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(36, 59, 85, 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          isLoading = true;
                        });
                        var email = _email.text;
                        var pass = _password.text;
                        login(email, pass, context);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 240,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color.fromRGBO(20, 30, 48, 1),
                            const Color.fromRGBO(36, 59, 85, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Adagio Sans",
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                  child: GestureDetector(
                    onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 240,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color.fromRGBO(20, 30, 48, 1),
                            const Color.fromRGBO(36, 59, 85, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Signup if not Register",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Adagio Sans",
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login(String email, String password, BuildContext context) async {
    try {
      var url = Uri.parse('https://www.gcet.ac.in/ddcet/items/getpwd');
      var data = {"email": email, "pwd": password}; // Make sure email and password are strings
      var response = await http.post(url, body: json.encode(data));

      if (response.statusCode == 200 ) {
        var message = jsonDecode(response.body);
        print(message);
        // print(message['status']);
        // var token = message['token'];
        // print('Token: $token');
        print(response.body);
        if (message['status']=='invalid')
        {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Alert"),
              content: const Text('Invalid email or password or account dosent exist'),
              actions: [
                TextButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Color.fromRGBO(36, 59, 85, 1)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomePage()),
          // );
        } else {
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     title: const Text("Alert"),
          //     content: const Text('Invalid email or password'),
          //     actions: [
          //       TextButton(
          //         child: const Text(
          //           'Ok',
          //           style: TextStyle(color: Color.fromRGBO(36, 59, 85, 1)),
          //         ),
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //         },
          //       ),
          //     ],
          //   ),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } else {
        print('Failed to fetch password. Error code:');
      }
    } catch (e) {
      print(e.toString());
    }
  }}
