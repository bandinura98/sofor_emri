import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sofor_emri/seferInfos.dart';
import 'package:http/http.dart' as http;
import 'package:sofor_emri/verification.dart';
import 'dart:convert';


import 'geomaplocation.dart';
import 'main.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
        title: "TOROFON",
        home: landingScreen()
    );
  }
}
class landingScreen extends StatelessWidget{
    Future<List<User>> getRequest() async {
      //replace your restFull API here.
      String url = "https://jsonplaceholder.typicode.com/posts";
      //String url = "http://194.87.17.119:3001/";
      final response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);

      //Creating a list to store input data;

      List<User> users = [];
      int iterator = 0;
      for (var singleUser in responseData) {
        iterator++;


        String yara_benim = singleUser["title"];
        String bodi = singleUser["body"];

        User user = User(
            id: singleUser["id"],
            userId: singleUser["userId"],
            title: yara_benim.substring(1,10),
            bodyDurum: bodi.substring(1,10),
            istbas: "31.01.1900",//singleUser["TARIH"],
            istson: "20.11.2022"//singleUser["UYARTAR"]
        );

        //Adding user to the list.
        if(iterator<10) {users.add(user);}
      }
      return users;
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Sürücü Görev")
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Verification(),
              ),
            );
          },
          child: Text("<",style: TextStyle(color: Colors.white, fontSize: 29),),
          //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getRequest(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot){
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          Align(
                            child: Text("Durum\nİstenen Başlangıç\nİstenen bitiş"),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(snapshot.data[index].title + "\n" + snapshot.data[index].istbas + "\n" + snapshot.data[index].istson,textAlign: TextAlign.right),
                          ),
                        ],
                      ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(

                              builder: (context) => SeferInfos(
                                  id: snapshot.data[index].id,
                                  userid: snapshot.data[index].userId,
                                  title: snapshot.data[index].title,
                                  bodydurum: snapshot.data[index].bodyDurum,
                                  istbas: snapshot.data[index].istbas,
                                  istson: snapshot.data[index].istson
                              ))
                      );
                    },
                    ),

                  ],
                )

                /*ListTile(
                  title: Text(snapshot.data[index].title),
                  subtitle: Text('Durum\nİstenen başlangıç\nİstenen bitiş'),
                  trailing: Text(snapshot.data[index].bodyDurum + "\n" + snapshot.data[index].istbas + "\n" + snapshot.data[index].istson,textAlign: TextAlign.right),
                  contentPadding: EdgeInsets.only(bottom: 20.0),
                  onTap: (){
                    Navigator.push(
                      context,
                    MaterialPageRoute(

                        builder: (context) => SeferInfos(
                            id: snapshot.data[index].id,
                            userid: snapshot.data[index].userId,
                            title: snapshot.data[index].title,
                            bodydurum: snapshot.data[index].bodyDurum,
                            istbas: snapshot.data[index].istbas,
                            istson: snapshot.data[index].istson
                        ))
                    );
                  },
                ),*/
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GeolocatorWidget(),
            ),
          );
        },
        child: Icon(Icons.map),
      ),
    );
  }
}


class User {
  final int id;
  final int userId;
  final String title;
  final String bodyDurum;
  final String istbas;
  final String istson;

  User({
    required this.id,
    required this.userId,
    required this.title,
    required this.bodyDurum,
    required this.istbas,
    required this.istson,
  });
}