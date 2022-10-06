import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayoff/model/company_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String key_company_id = 'comapny_id';
const String key_collection_company = 'comp';

class CompanyProfile with ChangeNotifier {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // CompanyProfile(this.firebaseFirestore);
  CompanyModel? companyModel;
  Future<void> loadProfile(String companyId) async {
    print("companyId $companyId");
    

    try {
      final snapshot = await firebaseFirestore
          .collection(key_collection_company)
          .doc(companyId)
          .get();
      if (snapshot.exists) {
        // UserLocalDataSource.setCompanyId(value.docs[0].id);
        companyModel = CompanyModel.fromMap(snapshot.data()!);
        notifyListeners();
        log(companyModel.toString());

        print('proifle data is getted');
      } else {
        this.companyModel = null;
        notifyListeners();
        print('profile  data dosenot exist');
      }
    } catch (e) {
      throw e;
    }
  }
}
