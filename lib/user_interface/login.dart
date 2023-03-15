import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/Utils/Globals.dart';
import 'package:moovbe/Utils/utils.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (await Utils.connectivityCheck()) {
      // Clear any previous error message

      // Call the Login API with the provided username and password
      final url = Uri.parse('http://flutter.noviindus.co.in/api/LoginApi');
      final response = await http.post(url, body: {
        // 'username': _usernameController.text.trim(),
        // 'password': _passwordController.text.trim(),
        'username': 'admin_user',
        'password': '123admin789',
      });

      if (response.statusCode == 200) {
        debugPrint('success');
        debugPrint(response.body);
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          final token = responseData['refresh'];
          debugPrint(token);
          Globals.tempToken = token.toString();
          Globals.url_id = responseData['url_id'];
          // Successful login, navigate to the next screen
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          var msg = responseData['message'];
          msg ??= 'check and try again';
          Fluttertoast.showToast(
              msg: msg.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        debugPrint('failed');
        debugPrint(response.body);
        // Login failed, display an error message
        Fluttertoast.showToast(
            msg: 'Try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    } else {
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Color.fromRGBO(43, 43, 43, 1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/images/Polygon.svg',
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                  ),
                  Positioned(
                      bottom: 60,
                      left: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: 41,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Manage yourBus and Drivers',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ],
                      ))
                ])),
            Container(
              // color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 60,
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Enter a name';
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: _usernameController,
                      obscureText: false,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter username',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 60,
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Enter your password';
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: _passwordController,
                      obscureText: false,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: InkWell(
                onTap: () {
                  _login();
                },
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(252, 21, 59, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
