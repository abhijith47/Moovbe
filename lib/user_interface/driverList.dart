import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moovbe/Utils/Globals.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/models/driverModel.dart';
import 'package:moovbe/providers/driverProvider.dart';
import 'package:provider/provider.dart';

import '../Utils/utils.dart';

class DriverListScreen extends StatefulWidget {
  static const routeName = '/driver_list';

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  @override
  void initState() {
    super.initState();
    getDrivers();
  }

  getDrivers() async {
    if (await Utils.connectivityCheck()) {
      final driverProvider =
          Provider.of<DriverProvider>(context, listen: false);
      final url = Uri.parse(
          'http://flutter.noviindus.co.in/api/DriverApi/${Globals.url_id}/');
      var response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${Globals.access}"},
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);

        var data = jsonDecode(response.body);
        debugPrint(data.toString());
        debugPrint(data['driver_list'].toString());
        if (data['driver_list'].length > 0) {
          driverProvider.driverList.clear();
          for (var i = 0; i < data['driver_list'].length; i++) {
            driverProvider.addDriverData(Driver(
              driverId: data['driver_list'][i]['id'].toString(),
              name: data['driver_list'][i]['name'].toString(),
              phoneNumber: data['driver_list'][i]['mobile'].toString(),
              licenseNo: data['driver_list'][i]['license_no'].toString(),
            ));
          }
        }
      } else {
        debugPrint(response.body);
        setState(() {});
        // TODO: Display an error message to the user
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

  deleteDriver(id) async {
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);
    final url = Uri.parse(
        'http://flutter.noviindus.co.in/api/DriverApi/${Globals.url_id}/');
    final token_response = await http.delete(
      url,
      body: {
        'driver_id': id,
      },
      headers: {"Authorization": "Bearer ${Globals.access}"},
    );
    if (token_response.statusCode == 200) {
      debugPrint(token_response.body);
      driverProvider.removeItem(id);
      Fluttertoast.showToast(
          msg: "driver removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      debugPrint(token_response.body);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context, listen: true);
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
      body: SizedBox(
          height:
              MediaQuery.of(context).size.height - Globals.statusbarHeight - 90,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  itemCount: driverProvider.driverList.length,
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
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    width: 60,
                                    height: 60,
                                    scale: .8,
                                    fit: BoxFit.none,
                                  ),
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
                                      Text(
                                          driverProvider.driverList[index].name
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54)),
                                      Container(
                                        color: Colors.transparent,
                                        width: 150,
                                        child: Text(
                                            'Licn no : ' +
                                                driverProvider
                                                    .driverList[index].licenseNo
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black54)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () async {
                                    if (await Utils.connectivityCheck()) {
                                      deleteDriver(driverProvider
                                          .driverList[index].driverId);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "No Internet Connection",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                      width: 80,
                                      height: 33,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(252, 21, 59, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Delete',
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
              ),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/add_Driver',
                      ).then((value) {
                        getDrivers();
                      });
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
          )),
    );
  }
}
