import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email = ''; // Define _email variable here

    Future<void> _checkEmailAndResetPassword(BuildContext context, String email) async {
      final response = await http.get(Uri.parse('https://gcet.ac.in/ddcet/items/register'));
      if (response.statusCode == 200) {
        if(response.body=='exist')
        // Email exists, navigate to the password update screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PasswordUpdateScreen(email: email)),
        );
      } else {
        // Email does not exist, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email does not exist')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter your email',
                ),
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_email.isNotEmpty) {
                    _checkEmailAndResetPassword(context, _email);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your email')),
                    );
                  }
                },
                child: const Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordUpdateScreen extends StatelessWidget {
  final String email;

  const PasswordUpdateScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Update password for $email'),
              // Add password update form or dialog here
            ],
          ),
        ),
      ),
    );
  }
}
