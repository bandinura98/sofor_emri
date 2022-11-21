import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sofor_emri/verification.dart';
import 'package:http/http.dart' as http;
import 'main.dart';


class KaydolTelefon extends StatelessWidget {
  const KaydolTelefon({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: "TOROFON",
      home: TelScreen()
    );
  }
}
String dropdownvalue = 'Item 1';

class TelScreen extends StatelessWidget{
  void RouterHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }//  Verification

  void RouterVerification(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => Verification()
      )
    );
  }

  final numCTRL = TextEditingController();
  final nameCTRL = TextEditingController();
  final plakaCTRL = TextEditingController();


  // Initial Selected Value


  // List of items in our dropdown menu
  var items = [
    'Türkiye',
    'Almanya',
    'Belçika',
    'Danimarka',
    'Çin',
  ];
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("KAYDOL")
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
              padding: const EdgeInsets.all(30.0),
              children: [
                Text("Size numaradınız doğrulamak için SMS göndereceğiz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                DropdownButtonFormField(
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    dropdownvalue = newValue!;
                    //setState(newValue);
                  },
                  // Initial Value
                  value: dropdownvalue,
                ),
                Stack(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Positioned(
                        child: Text("+90"),
                        left: 0,
                    ),
                    TextField(
                      controller: numCTRL,
                      decoration: InputDecoration(labelText: "NUMARA"),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                TextField(
                  controller: nameCTRL,
                  decoration: InputDecoration(labelText: "ŞİRKET ADI "),
                ),
                TextField(
                  controller: plakaCTRL,
                  decoration: InputDecoration(labelText: "PLAKA"),
                ),



              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50)
              ),
              child: Text("KAYIT OL"),
              onPressed: () async {
                dropdownvalue;
                numCTRL;//apiye yolluyor benim dalgam biter
                nameCTRL;
                plakaCTRL;
                await http.get(Uri.parse('http://194.87.17.119/create/sofor?number=' + numCTRL.text + '&name='+ nameCTRL.text +'&dd='+ dropdownvalue +'&plaka='+ plakaCTRL.text +''));




                RouterVerification(context);


                /*
                * This particular function must contains the falowing structers
                *
                * phone num
                * name
                * imei
                *
                * and must send those values to the api and make a valid request
                * for users to sign in the program properly
                *
                * than send this user to verification steps
                *
                * its now just sends to the verification steps
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