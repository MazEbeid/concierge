import 'package:camp_concierge/pages/MainPage.dart';
import 'package:camp_concierge/utils/Helper.dart';
import 'package:flutter/material.dart';
void main() async {

  runApp(MaterialApp(
    home: MainPage(groups: Helper().testGroup,),
    debugShowCheckedModeBanner: false,
  ));
}



