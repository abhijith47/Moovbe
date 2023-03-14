import 'dart:math';

class Bus {
  String busId;
  String driverId;
  String drivername;
  String driverlicense;
  int seatCount;
  int layout;
  String busBrand;
  String busDescription;

  Bus(
      {required this.busId,
      required this.driverId,
      required this.seatCount,
      required this.driverlicense,
      required this.drivername,
      required this.busBrand,
      required this.busDescription,
      required this.layout});
}
