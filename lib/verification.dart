import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sofor_emri/landingPage.dart';

import 'main.dart';


class Verification extends StatelessWidget {
  const Verification({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
        title: "TOROFON",
        home: MyScreen()
    );
  }
}
String dropdownvalue = 'Item 1';

class MyScreen extends StatelessWidget{
  void RouterHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );

  }
  void RouterLanding(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Landing(),
      ),
    );

  }


  // Initial Selected Value


  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("ONAY")
          ),
          leading:
          TextButton(
            onPressed: () {
              RouterHome(context);
            },
            child: Text("<",style: TextStyle(color: Colors.white, fontSize: 29),),
            //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),

        ),
        body: Stack(
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
                  Center(child: new Text('Size bir doğrulama SMS\'i gönderdik')),
                  Center(child: new Text('SMS\'in içerisindeki doğrulama kodunu aşağıya giriniz')),
                  TextField(),

                ]
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50)
                ),
                child: Text("KAYIT OL"),
                onPressed: (){
                  RouterLanding(context);
                  /*
                  * checks the verification
                  *
                  *
                  *
                  * this particular screen makes the user valid
                  *
                  * and goes to landing page
                  *
                  * */
                },
              ),
            )
          ],
        )
    );
  }
}