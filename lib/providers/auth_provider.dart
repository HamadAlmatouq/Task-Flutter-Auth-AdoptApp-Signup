import 'dart:io';

import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/services/auth.dart';
import 'package:adopt_app/services/pets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  late User user;

  void signup({required User user}) async {
    token = await AuthServices().signup(user: user);
    print(token);
    notifyListeners();
  }

  void signin({required User user}) async {
    token = await AuthServices().signin(user: user);
    print(token);
    notifyListeners();
  }

  // bool get isAuth {
  //   if (token.isNotEmpty && Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
  //     user = User.fromJson(Jwt.parseJwt(token));
  //     return true;
  //   }
  //   return false;
  // }

  bool get isAuth {
    if (token.isNotEmpty && Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
      user = User.fromJson(Jwt.parseJwt(token));

      // HttpHeaders.authorizationHeader: "Bearer $token";
      return true;
    }
    return false;
  }

  Future<void> initilaizeAuth() async {
    await _getToken();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
    print("getting token from prefs: ${prefs.getString("token")}");
    notifyListeners();
  }

  void logout() {
    token = "";
    notifyListeners();
  }
}


// For refrence 

// class Human {

//   String firstName = "Hamad";
//   String lastName = "Almaatoq";

//   String get fullName => "$firstName $lastName";

//   int get firstNameLength {
//     return firstName.length;
//   }
// }

// void x() {
//   print(Human().firstNameLength); //5
// }
