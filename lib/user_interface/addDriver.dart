import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/Utils/Globals.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Utils/utils.dart';

class addDriver extends StatefulWidget {
  static const routeName = '/add_Driver';

  @override
  State<addDriver> createState() => _addDriverState();
}

class _addDriverState extends State<addDriver> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    licenseController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  saveDriver() async {
    final url = Uri.parse(
        'http://flutter.noviindus.co.in/api/DriverApi/${Globals.url_id}/');
    final token_response = await http.post(
      url,
      body: {
        'name': nameController.text,
        'mobile': phoneController.text,
        'license_no': licenseController.text
      },
      headers: {"Authorization": "Bearer ${Globals.access}"},
    );
    if (token_response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "Try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(43, 43, 43, 1),
        centerTitle: true,
        toolbarHeight: 90,
        title: const Text(
          'Driver List',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 10,
                right: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                        controller: nameController,
                        obscureText: false,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Name',
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
                          if (value == null ||
                              value == '' ||
                              value.trim().length < 10) {
                            return 'Enter a valid mobile number';
                          }
                        },
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        controller: phoneController,
                        obscureText: false,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Mobile Number',
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
                            return 'Enter license number';
                          }
                        },
                        controller: licenseController,
                        obscureText: false,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter License Number',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (await Utils.connectivityCheck()) {
                          saveDriver();
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
                          'Add Driver',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
