import 'package:flutter/material.dart';
import 'package:moovbe/models/driverModel.dart';

class DriverProvider with ChangeNotifier {
  Driver _driverData = Driver();
  List<Driver> driverList = [];

  List<Driver> get driverData {
    return driverList;
  }

  void addDriverData(Driver obj) {
    _driverData = obj;
    driverList.add(_driverData);
    notifyListeners();
  }

  void removeItem(docId) {
    driverList.removeWhere((item) => item.driverId == docId);

    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
