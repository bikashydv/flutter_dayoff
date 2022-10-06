import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayoff/model/holidayRequestmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../shared_prefs/user_local_data_source.dart';

const String holiday_collection = "holiday";

class HolidayRequestProvider extends ChangeNotifier {
  bool isLoading = false;
  String? message;
  List<HolidayRequestModel> holidaysRequested = [];

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> requestHoliday(HolidayRequestModel holidayRequestModel) async {
    try {
      isLoading = true;
      notifyListeners();
      holidayRequestModel.userId = await UserLocalDataSource.getUserId();
      await firebaseFirestore
          .collection(holiday_collection)
          .add(holidayRequestModel.toMap());

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      print(e.toString());
      return false;
    }
  }

  Future<List<HolidayRequestModel>> getRequestedHolidays() async {
    try {
      isLoading = true;
      notifyListeners();
      final snapshot =
          await firebaseFirestore.collection(holiday_collection).get();
      List<HolidayRequestModel> allHolidays = List<dynamic>.from(snapshot.docs)
          .map((e) => HolidayRequestModel.fromMap(e))
          .toList();
      holidaysRequested = allHolidays;
      isLoading = false;
      notifyListeners();
      return holidaysRequested;
    } catch (e) {
      throw e;
    }
  }
}
