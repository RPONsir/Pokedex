import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  Future<StreamSubscription> internetCheckingStatus(context) async {
    // Simple check to see if we have internet
    //print("The statement 'this machine is connected to the Internet' is: ");
    //print(await InternetConnectionChecker().hasConnection);
    //print("Current status: ${await InternetConnectionChecker().connectionStatus}");
    StreamSubscription listener =
        InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          //print('Data connection is available.');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //fetchPokemonData();
          break;
        case InternetConnectionStatus.disconnected:
          //print('You are disconnected from the internet.');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            padding: EdgeInsets.all(10),
            content: Text(
              'No Internet Connection Detected',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            showCloseIcon: true,
            backgroundColor: Colors.blueGrey,
            closeIconColor: Colors.white,
            duration: Duration(seconds: 10),
          ));
          break;
      }
    });
    return listener;
  }
}
