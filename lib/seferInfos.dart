import 'package:flutter/material.dart';
import 'package:sofor_emri/landingPage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AddDuty.dart';
import 'main.dart';

int num = 0;
int uid = 0;
String baslik = "";
String durum = "";
String bas = "";
String son = "";

class SeferInfos extends StatelessWidget {

  final int id;

  final int userid;

  final String title;

  final String bodydurum;

  final String istbas;

  final String istson;



  const SeferInfos({super.key,required this.id,required this.userid,required this.title,required this.bodydurum,required this.istbas,required this.istson});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint('movieTitle: $id');
    num = id;
    uid = userid;
    durum = bodydurum;
    bas = istbas;
    son = istson;
    baslik = title;

    return MaterialApp(
        title: "TOROFON",
        home: MyScreen()
    );
  }
}

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
  var listem = ["yolda","araç bozuldu","kargo yükleniyor","kaza yapıldı","köförün eltisi doğum yapmış","şöför depresyona girip işi bıraktı"];


  Future<List<User>> getRequestUser() async {
    String url = "http://jsonplaceholder.typicode.com/posts/$num";
    debugPrint('reqnum: $url');
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);



    //Creating a list to store input data;

    List<User> users = [];
    for (var singleUser in responseData) {
      User user = User(
          id: singleUser["ID"],
          userId: singleUser["FNO"],
          title: singleUser["MAD"],
          bodyDurum: (listem..shuffle()).first,
          istbas: singleUser["TARIH"],
          istson: singleUser["UYARTAR"]
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          actions: [
            Text("ROTA          "),
          ],
          title: Center(
              child: Text("TEST")
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
        body: ListView(
          //padding: const EdgeInsets.all(16.0),

          children: [
            Stack(
            children: [
              Align(
                child: Text("Durum\nİstenen başlangıç\nGerçekleşen başlangıç\nİstenen bitiş\nGerçekleşen bitiş"),
                alignment: Alignment.topLeft,
              ),
              Align(
                child: Text(durum + "\n" + bas + "\n" +son + "\n" + "henüz bitmedi\nhenüz bitmedi"),
                alignment: Alignment.topRight,
              ),
            ],
            ),
            FutureBuilder(
              future: getRequestUser(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot){
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text((listem..shuffle()).first)
                    ),
                  );
                } else {
                  return ListView.builder(

                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,

                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) =>
                        Card(
                          child: ListTile(
                            leading: FlutterLogo(),//apiden data verilmedi
                            title: Text(snapshot.data[index].bodyDurum),
                          ),
                        ),



                    /*burada listtileyi sil sonracıma şe yap align ile hallet falan .s*/
                        /*ListTile(
                          title: Center( child: Text(snapshot.data[index].title)),
                          subtitle: Text('Durum\nİstenen başlangıç\ngerçekleşen başlangıç\nİstenen bitiş\n gerçekleşen bitiş'),
                          trailing: Text(snapshot.data[index].bodyDurum + "\n" + snapshot.data[index].istbas + "\n" + snapshot.data[index].istson + "\n" + snapshot.data[index].istson + "\n" + snapshot.data[index].istson),
                          contentPadding: EdgeInsets.only(bottom: 20.0),

                    ),*/
                  );
                }
              },
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDuty(
                num,
                uid,
                baslik,
                son,
                bas,
                durum,
              ),
            ),
          );
        },
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