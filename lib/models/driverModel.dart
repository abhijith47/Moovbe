import 'dart:math';

class Driver {
  String name;
  int driverId;
  int age;
  String phoneNumber;
  String address;

  Driver(
      {required this.name,
      required this.driverId,
      required this.age,
      required this.phoneNumber,
      required this.address});
}

List<Driver> generateDummyData(int count) {
  List<String> names = [
    "John",
    "Sarah",
    "Bob",
    "Jane",
    "Tom",
    "Alice",
    "Peter",
    "Emily",
    "David",
    "Linda"
  ];

  List<String> addresses = [
    "123 Main St",
    "456 Oak Ave",
    "789 Maple Ln",
    "321 Elm St",
    "654 Pine Rd",
    "890 Cedar St",
    "246 Birch Ave",
    "357 Elmwood Dr",
    "802 Maplewood Ave",
    "441 Cedarwood Ln"
  ];

  Random random = Random();

  List<Driver> drivers = [];

  for (int i = 0; i < count; i++) {
    String name = names[random.nextInt(names.length)];
    int driverId = random.nextInt(9999);
    int age = 18 + random.nextInt(62);
    String phoneNumber = "555-${random.nextInt(9000) + 1000}";
    String address = addresses[random.nextInt(addresses.length)];

    drivers.add(Driver(
        name: name,
        driverId: driverId,
        age: age,
        phoneNumber: phoneNumber,
        address: address));
  }

  return drivers;
}
