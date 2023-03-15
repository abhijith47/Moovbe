import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moovbe/Utils/Globals.dart';
import 'package:moovbe/models/busModel.dart';

class BusDetails extends StatefulWidget {
  static const routeName = '/bus_details';

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  late Bus singlebus;
  List<Widget> finalSeats = [];

  sideSeatedBus(Bus bus) {
    //bus with only 1 seat at left side
    for (int j = 0; j < 4; j++) {
      finalSeats.add(
        Container(
          width: 30,
        ),
      );
    }
    finalSeats.add(SizedBox(
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          'assets/images/seat_black.svg',
          fit: BoxFit.scaleDown,
        )));
    var seats = bus.seatCount;
    debugPrint(seats.toString());
    for (int i = 1; i <= seats; i++) {
      if (i == 3 || (i > 5 && (i - 3) % 5 == 0)) {
        seats = seats + 1;
        finalSeats.add(
          Container(
            width: 30,
          ),
        );
      } else {
        finalSeats.add(BusSeat());
      }
    }
  }

  normalSeatedBus(Bus bus) {
    //bus with only 2 seats on either side
    for (int j = 0; j < 4; j++) {
      finalSeats.add(
        Container(
          width: 30,
        ),
      );
    }
    finalSeats.add(SizedBox(
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          'assets/images/seat_black.svg',
          fit: BoxFit.scaleDown,
        )));
    var seats = bus.seatCount;
    debugPrint(seats.toString());
    for (int i = 1; i <= seats; i++) {
      if (i == 2 || (i > 2 && (i - 2) % 5 == 0)) {
        seats = seats + 1;
        finalSeats.add(
          Container(
            width: 30,
          ),
        );
      } else {
        finalSeats.add(BusSeat());
      }
    }
  }

  Widget driverContainer(color, title, subtitle, image) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: color),
        height: 130,
        // width: MediaQuery.of(context).size.width * .85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      'License  : ' + subtitle,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                image,
                width: 150,
                fit: BoxFit.scaleDown,
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool instance = true;
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    if (instance) {
      instance = false;
      singlebus = argument['bus_data'];

      if (singlebus.layout == 13) {
        sideSeatedBus(singlebus);
      } else {
        normalSeatedBus(singlebus);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(43, 43, 43, 1),
        centerTitle: true,
        toolbarHeight: 90,
        title: Text(
          singlebus.busBrand.toString() + ' ' + singlebus.busDescription,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height:
              MediaQuery.of(context).size.height - Globals.statusbarHeight - 90,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              driverContainer(
                  const Color.fromRGBO(43, 43, 43, 1),
                  singlebus.drivername,
                  singlebus.driverlicense,
                  'assets/images/driver.png'),
              Expanded(
                //   height: MediaQuery.of(context).size.height * .9,
                // width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 20, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: finalSeats.length,
                      itemBuilder: (BuildContext context, int index) {
                        return finalSeats[index];
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BusSeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          'assets/images/seat_red.svg',
          fit: BoxFit.scaleDown,
        ));
  }
}
