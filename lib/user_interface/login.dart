import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/Utils/Globals.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    // Clear any previous error message
    setState(() {
      _errorMessage = '';
    });

    // Call the Login API with the provided username and password
    final url = Uri.parse('http://flutter.noviindus.co.in/api/LoginApi');
    final response = await http.post(url, body: {
      // 'username': _usernameController.text,
      // 'password': _passwordController.text,
      'username': 'admin_user',
      'password': '123admin789',
    });

    if (response.statusCode == 200) {
      debugPrint('success');
      debugPrint(response.body);
      final responseData = jsonDecode(response.body);
      final token = responseData['refresh'];
      debugPrint(token);
      Globals.tempToken = token.toString();
      Globals.url_id = responseData['url_id'];
      // Successful login, navigate to the next screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      debugPrint('failed');
      debugPrint(response.body);
      // Login failed, display an error message
      final responseData = jsonDecode(response.body);
      setState(() {
        _errorMessage = responseData['error'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 10),
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
