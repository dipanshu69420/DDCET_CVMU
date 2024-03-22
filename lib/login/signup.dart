import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cvmuproject/login/login.dart';
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _college = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                    height: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _firstname,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter a first name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'First Name',
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _lastname,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter a last name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'Last Name',
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _college,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter valid College';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'College',
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _mobile,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter valid mobile number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'Mobile No.',
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _city,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter valid city';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'City',
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _state,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Enter valid state';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(238, 238, 238, 1),
                        hintText: 'State',
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
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
                          return 'Enter valid email';
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 240,
                    height: 50,
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
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 6),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          isLoading = true;
                        });
                        var firstname = _firstname.text;
                        var lastname = _lastname.text;
                        var college = _college.text;
                        var mobile = _mobile.text;
                        var city = _city.text;
                        var state = _state.text;
                        var email = _email.text;
                        var pass = _password.text;
                        signup(
                            firstname,
                            lastname,
                            college,
                            mobile,
                            city,
                            state,
                            email,
                            pass,
                            context);
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
                        "Sign Up",
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
    ));
  }

  void signup(String firstname, String lastname, String college, String mobile, String city, String state, String email, String password, BuildContext context) async {
    try {
      var url = Uri.parse('https://www.gcet.ac.in/ddcet/items/register');
      var data = {
        "firstName": firstname,
        "lastName": lastname,
        "college": college,
        "mobile": mobile,
        "state": state,
        "email": email,
        "city": city,
        "pwd": password
      };
      print(data); // Make sure email and password are strings
      var response = await http.post(url, body: json.encode(data));
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body == "Success") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else if (response.body == "exist") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Alert"),
              content: const Text('Email already exists. Please use a different email or login.'),
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
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Alert"),
              content: const Text('Email Already Registered.'),
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
        }
      } else {
        print('Failed to fetch data. Error code:');
      }
    } catch (e) {
      print(e.toString());
    }
  }}