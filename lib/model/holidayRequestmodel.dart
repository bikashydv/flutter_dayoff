import 'package:cloud_firestore/cloud_firestore.dart';

class HolidayRequestModel {
  DateTime  starttime;
  DateTime endtime;
  String? userId;
  bool status;

  HolidayRequestModel(
      {required this.endtime,
      required this.starttime,
      this.status = false,
      this.userId});

   factory HolidayRequestModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
        final data = snapshot.data();

    return HolidayRequestModel(
      // endtime:DateTime.fromMillisecondsSinceEpoch( data!['endtime']*1000),
      // starttime: DateTime.fromMillisecondsSinceEpoch(data['starttime']*1000),
      endtime: (data!['endtime']as Timestamp).toDate(),
      starttime: (data['sarttime']as Timestamp).toDate(),

      userId: data['userId'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'endtime': endtime,
      'sarttime': starttime,
      'status': status,
      'userId': userId,
    };
  }
}
