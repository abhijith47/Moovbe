import 'package:flutter/material.dart';
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
    var seats = 36;

    for (int i = 0; i <= seats; i++) {
      if (i >= 3) {
        if ((i + 1) % 4 == 0) {
          finalSeats.add(
            Container(
              width: 30,
            ),
          );
        } else {
          finalSeats.add(BusSeat());
        }
      } else {
        finalSeats.add(BusSeat());
      }
    }
    finalSeats.removeAt(0);
    //finalSeats.removeAt(1);
    print(finalSeats);
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
      sideSeatedBus(singlebus);
      if (singlebus.layout == 13) {
      } else {
        // normalSeated();
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 90,
        title: const Text(
          'ksrtc swift scania',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 90,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            driverContainer(Colors.black, singlebus.drivername,
                singlebus.driverlicense, 'assets/images/driver.png'),
            Container(
              height: 500,
              width: 300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                ),
                itemCount: finalSeats.length,
                itemBuilder: (BuildContext context, int index) {
                  return finalSeats[index];
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BusSeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '3',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
