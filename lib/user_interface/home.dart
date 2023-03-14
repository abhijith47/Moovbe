import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/models/busModel.dart';

import '../Utils/Globals.dart';
import 'busDetails.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bus> buses = [];

  @override
  void initState() {
    super.initState();
    getBusList();
    _fetchBusList();
  }

  getBusList() async {
    Random random = Random();
    int total_buses = 5;
    List<String> names = ['Alice', 'Bob', 'Charlie', 'David', 'Emma'];
    List<String> busBrand = ['KSRTC', 'KSRTC', 'KSRTC', 'KSRTC', 'KSRTC'];
    List<String> busDescription = [
      'Swift scania P-series',
      'Swift scania K-series',
      'Swift scania F-series',
    ];

    for (int i = 0; i < total_buses; i++) {
      String busId = random.nextInt(9999).toString() + i.toString();
      String driverId = i.toString() + random.nextInt(9999).toString();
      int seatCount = 30 + random.nextInt(20); // seat count between 20 and 50
      int layout = random.nextInt(2) == 0 ? 13 : 22;
      String driverlicense =
          i.toString() + driverId + random.nextInt(9999).toString();
      String drivername = names[Random().nextInt(names.length)];
      String BusBrand = busBrand[Random().nextInt(busBrand.length)];
      String BusDescription =
          busDescription[Random().nextInt(busDescription.length)];

      buses.add(Bus(
          busId: busId,
          driverId: driverId,
          seatCount: seatCount,
          layout: layout,
          driverlicense: driverlicense,
          busBrand: BusBrand,
          busDescription: BusDescription,
          drivername: drivername));
    }
  }

  Future<void> _fetchBusList() async {
    final url1 =
        Uri.parse('http://flutter.noviindus.co.in/api/api/token/refresh/');
    final token_response =
        await http.post(url1, body: {'refresh': Globals.tempToken});
    if (token_response.statusCode == 200) {
      debugPrint('success');
      debugPrint(token_response.body);
      final responseData = jsonDecode(token_response.body);
      final token = responseData['refresh'];
      debugPrint(token);
      Globals.tempToken = token.toString();
      Globals.access = responseData['access'];
      // Successful login, navigate to the next screen

    } else {
      debugPrint('failed');
      debugPrint(token_response.body);
      // Login failed, display an error message
    }

    // final url = Uri.parse(
    //     'http://flutter.noviindus.co.in/api/BusListApi/${Globals.url_id}/');
    // var response = await http.get(
    //   url,
    //   headers: {"Authorization": "Bearer ${Globals.access}"},
    // );
    // final url = Uri.parse(
    //     'http://flutter.noviindus.co.in/api/BusListApi/${Globals.access}/');
    // // final url = Uri.parse(
    // //     'http://flutter.noviindus.co.in/api/DriverApi//${Globals.url_id}/');
    // final response = await http.post(url, body: {
    //   // 'username': _usernameController.text,
    //   // 'password': _passwordController.text,
    //   'bus_id': '1',
    //   'driver_id': '1',
    //   'name': 'ksrtc swift'
    // });
    // print(url.toString());
    // if (response.statusCode == 200) {
    //   print(response.body);

    //   var data = jsonDecode(response.body);
    //   print(data.toString());
    //   print(data.toString());
    // } else {
    //   print(response.body);
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   // TODO: Display an error message to the user
    // }
    // print(_busList);
    // print(_busList.length);
  }

  Widget homecontainer(color, title, subtitle, image) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color),
      height: 200,
      width: 175,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              image,
              width: 150,
              fit: BoxFit.scaleDown,
              height: 140,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 90,
        title: Image.asset(
          'assets/logo.png',
          width: 150,
          fit: BoxFit.fitWidth,
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 90,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    homecontainer(Colors.red, 'Bus', 'Manage your Bus',
                        'assets/images/yellow_bus.png'),
                    homecontainer(Colors.black, 'Driver', 'Manage you Driver',
                        'assets/images/driver.png')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(buses.length.toString() + ' buses found',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: buses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: Image.asset(
                                  'assets/images/white_bus.png',
                                  width: 50,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(buses[index].busBrand,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54)),
                                      Text(buses[index].busDescription,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    var data = buses[index];
                                    Navigator.pushNamed(context, '/bus_details',
                                        arguments: {'bus_data': data});
                                  },
                                  child: Container(
                                      width: 80,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Manage',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      ))),
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          )),
      extendBody: true,
    );
  }
}
