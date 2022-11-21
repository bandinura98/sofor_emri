import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:sofor_emri/kaydolTelefon.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: "ŞÖFÖR BİLGİ SİSTEMİ",
      home: HomeScreen()


    );
  }
}

class HomeScreen extends StatelessWidget{

  void RouterSign(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KaydolTelefon(),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://picsum.photos/250?image=9',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(14.0),
                child: Text('ŞÖFÖR BİLGİ SİSTEMİ'))
          ],
        ),
      ),
      body:
      Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("EN"),
            ),
          ),
          Center(


              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(30.0),
                children: const <Widget>[
                  Text("SÜRÜCÜ GÖREVE HOŞ GELDİNİZ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                      "Uygulama kaydolarak taşımasını yapacağınız yükleri görebilir ve yükler hakkında istenilen bilgileri doldurabilirsiniz."),
                  Text(''),
                  Text(
                      'Kaydolmanız halinde Hizmet Şartlarımızı ve Gizlilik Politikamızı kabul etmiş olursunuz.'),
                  SelectableLinkify(
                    text: "\nHizmet Politikamız https://hizmetpolitikamız.com\n\nGizlilik politikamız: https://gizlililpolitikasi.com",
                  )
                ],
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,

            child: ElevatedButton(
              onPressed: () {
                RouterSign(context);
              },
              child: Text("KABUL ET VE BAŞLA"),
            ),
          )
        ],
      ),


    );

  }
}