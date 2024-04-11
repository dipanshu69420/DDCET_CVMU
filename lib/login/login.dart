import 'package:cvmuproject/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cvmuproject/views/home_screen.dart';
import 'dart:convert';
import 'package:cvmuproject/login/forgorpassword.dart';
import 'package:intl/intl.dart';


class Login extends StatefulWidget {
  static Locale selectedLocale = const Locale('en', 'US'); // Define selectedLocale here

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
  static Locale getSelectedLocale() {
    return selectedLocale;
  }

  static void setSelectedLocale(Locale locale) {
    selectedLocale = locale;
  }
}


class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  late Locale _selectedLocale = Locale('en', 'US');
  late Map<String, String> _localizedStrings={};




  @override
  void initState() {
    super.initState();
    _selectedLocale = Locale('en', 'US'); // Default locale
    _loadLocalizedStrings(_selectedLocale);
    print("First");
    print(_selectedLocale);
  }

  // void _setLocale(Locale locale) {
  //   setState(() {
  //     Login.setSelectedLocale(locale);
  //     print("Inside Method");
  //     print(locale);
  //   });
  // }


  Future<void> _loadLocalizedStrings(Locale locale) async {
    String langCode = locale.languageCode;
    String countryCode = locale.countryCode ?? '';
    String localeName = langCode + (countryCode.isNotEmpty ? '_' + countryCode : '');

    String jsonContent = await DefaultAssetBundle.of(context).loadString('assets/lang/$localeName.json');
    Map<String, dynamic> decodedMap = jsonDecode(jsonContent);
    Map<String, String> localizedStrings = Map<String, String>.from(decodedMap);
    print(localizedStrings);
    print(localeName);
    setState(() {
      _localizedStrings = localizedStrings;
    });
  }


  void _changeLanguage(Locale? locale) async {
    if (locale != null) {
      setState(() {
        _selectedLocale = locale;
      });
      await _loadLocalizedStrings(locale);
      Login.setSelectedLocale(locale!); // Update the selectedLocale in Login class
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_localizedStrings?['login'] ?? 'Login'),
          actions: [
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                _changeLanguage(
                    _selectedLocale == Locale('en', 'US') ? Locale('gu', 'IN') : Locale('en', 'US')
                );
                print("Hello");
                print("Hello");
                print(_selectedLocale);
              },
            ),
            DropdownButton<Locale>(
              value: _selectedLocale,
              onChanged: (value) {
                setState(() {
                  _selectedLocale = value!;
                });
                _changeLanguage(value); // Call _changeLanguage method with the selected locale
              },
              items: [
                DropdownMenuItem(
                  value: const Locale('en', 'US'),
                  child: const Text('English'),
                ),
                DropdownMenuItem(
                  value: const Locale('gu', 'IN'),
                  child: const Text('ગુજરાતી'),
                ),
              ],
            ),

          ],
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.95,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),  // Add padding to the top
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/cvmu-logo.png",
                          height: 200,
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
                          controller: _email,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return _selectedLocale == const Locale("gu", "IN") ? 'માન્ય ઈમેલ આઈડી દાખલ કરો' : 'Enter Valid Email ID';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(238, 238, 238, 1),
                            hintText: _localizedStrings?['email'] ?? 'Email',
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
                              return _selectedLocale == const Locale("gu", "IN") ? 'માન્ય પાસવર્ડ દાખલ કરો' : 'Enter Valid Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(238, 238, 238, 1),
                            hintText: _localizedStrings?['password'] ?? 'Password',
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
                          child: Text(
                            _localizedStrings?['login'] ?? 'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Adagio Sans",
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => ForgotPassword()),
                    //       );
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       width: 240,
                    //       height: 60,
                    //       decoration: BoxDecoration(
                    //         gradient: LinearGradient(
                    //           begin: Alignment.topCenter,
                    //           end: Alignment.bottomCenter,
                    //           colors: [
                    //             const Color.fromRGBO(20, 30, 48, 1),
                    //             const Color.fromRGBO(36, 59, 85, 1),
                    //           ],
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: const Text(
                    //         "Forgot Password",
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //           fontFamily: "Adagio Sans",
                    //           color: Color.fromRGBO(255, 255, 255, 1),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),




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
                          child: Text(
                            _localizedStrings?['signup'] ?? 'Signup',
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
              title: Text(_selectedLocale == const Locale("gu", "IN") ? 'ચેતવણી' : 'Alert'),
              content: Text(_selectedLocale == const Locale("gu", "IN") ? 'અમાન્ય ઇમેઇલ અથવા પાસવર્ડ અથવા એકાઉન્ટ અસ્તિત્વમાં નથી' : 'Invalid email or password or account dosent exist'),
              actions: [
                TextButton(
                  child: Text(
                    _selectedLocale == const Locale("gu", "IN") ? 'ઓકે' : 'Ok',
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
          Locale newLocale = _selectedLocale == Locale('en', 'US') ? Locale('en', 'US') : Locale('gu', 'IN');
          print('Current selectedLocale: $_selectedLocale');
          print('New locale to be set: $newLocale');
          _changeLanguage(newLocale);
          setState(() {
            _selectedLocale = newLocale;
          });
          try {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(selectedLocale: newLocale)),
            );
          } catch (e) {
            print('Error navigating to HomePage: $e');
          }
        }
      } else {
        print('Failed to fetch password. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }}
