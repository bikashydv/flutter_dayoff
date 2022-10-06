import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayoff/model/company_profile_model.dart';
import 'package:flutter/material.dart';

import '../shared_prefs/user_local_data_source.dart';

const String key_password = 'passwod';
const String key_email = 'email_id';
const String key_collection_email = 'user';

///[Bikash]
///[0]map to model  [done]
///[1]username,password,email,company_id,holiday_id etc...
///[2]save to database//sharedpreference//hive
///[3]boolean value loggedin ->true
///[4]then goto dashboard page

class AuthProvider with ChangeNotifier {
  bool? isLogedin;
  String? errorMessage;
  // User? userId;
  final FirebaseFirestore firebaseFirestore;

  AuthProvider(this.firebaseFirestore);

  //logout()
  //clear database
  //set user loggedin bool as null or false
  // /logic
  //query where user name = $user and password = $password
  //if query is success
  // user exists
  //if query is failure
  // user doesnot exist
  /// [Bikash]
  ///

  ///used to save userprofilemodel instance temporarily
  ///for future usecase scenerio
  UserModel? userModel;
  Future<void> logIn(String username, String passwords) async {
    print("user name $username");
    print('password $passwords');

    firebaseFirestore
        .collection(key_collection_email)
        .where(key_email, isEqualTo: username)
        .where(key_password, isEqualTo: passwords)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) {
      value.docs.forEach((key) {
        key.data().forEach((key, value) {
          print("key $key Value $value");
        });
      });
        try {

      //if user name and password is correct      
      //it return  user
      if (value.docs.length > 0) {
          // value.docs[0].id;
          UserLocalDataSource.setUserId(value.docs[0].id);
          //user exists
          //yo run??
          print("user foud");

          isLogedin = true;
          errorMessage = null;

          ///[bikash]
          ///saved user profile model temporily
          userModel = UserModel.fromMap(value.docs[0].data());

          notifyListeners();
      
      } else {
        print("user not foud");
        isLogedin = false;
        errorMessage = "User doesnot exist";

        ///[bikash]
        ///clear user profile model if user is not found/invalid credential
        userModel = null;
        notifyListeners();
        //yo run??
        ///[Bikash]
        //user doesnot exists
        //show user not found(email password doesnot match)

      }
        } catch (e) {
          print("Error====> $e");
           isLogedin = false;
        errorMessage = "$e";

        ///[bikash]
        ///clear user profile model if user is not found/invalid credential
        userModel = null;
        notifyListeners();
        }
    });
  }
}
