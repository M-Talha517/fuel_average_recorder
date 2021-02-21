import'package:flutter/material.dart';
import 'package:fuel_average_recorder/models/user.dart';
import 'package:fuel_average_recorder/screens/authentication/authentication.dart';
import 'package:fuel_average_recorder/screens/home/home.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CurrUser currUser = Provider.of<CurrUser>(context);
    return currUser == null? AuthenticationScreen() : HomeScreen();
  }
}
