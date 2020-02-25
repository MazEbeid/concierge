import 'dart:convert';
import 'package:camp_concierge/pages/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.groups}) : super(key: key);

  final List<dynamic> groups;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  var editedGroups;
  var json;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text("Settings"),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.close),
                splashColor: Colors.white,
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (_)=>MainPage(groups: widget.groups,)
                  ));
                },
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: 150,
              height: MediaQuery.of(context).size.height*0.7,
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                maxLines: 16,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter test data",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onEditingComplete: () {},
                onChanged: (text) {
                    editedGroups = text;
                },
              ),
            ),
         Align(
             child:RaisedButton(
               shape: StadiumBorder(),
               color: Colors.white,
               onPressed: () {
                 try{
                   if(editedGroups!="")
                   {
                     json = jsonDecode(editedGroups);
                     Navigator.pushReplacement(context, MaterialPageRoute(
                         builder: (_)=>MainPage(groups: json,)
                     ));
                   }
                   else{

                     Navigator.pushReplacement(context, MaterialPageRoute(
                         builder: (_)=>MainPage(groups: widget.groups,)
                     ));
                   }
                 }catch(exception)
                 {
                   print(exception.toString());
                       Toast.show("Please enter valid data", context, gravity: Toast.CENTER, backgroundColor: Colors.redAccent);
                 }


               },
               child: Text(
                 "Save",
                 style: TextStyle(color: Colors.black),
               ),
             ),
         )
          ],
        ));
  }

}