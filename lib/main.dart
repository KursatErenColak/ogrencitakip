import 'package:flutter/material.dart';
import 'package:flutter_app/Models/ogrencimodel.dart';
import 'package:flutter_app/Screens/ogrenci_add.dart';

import 'Screens/ogrenci_update.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "Merhaba ilk uygulama";

  Ogrenci selectedStudent = Ogrenci.withId(0, "", " ", 0, "");

  List<Ogrenci> ogrenciler = [
    new Ogrenci.withId(1, "Kursat", "Colak", 55,
        "https://cdn.pixabay.com/photo/2018/01/17/07/06/laptop-3087585__340.jpg"),
    Ogrenci.withId(2, "Eren", "Colak", 75,
        "https://cdn.pixabay.com/photo/2018/09/11/19/49/education-3670453__340.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text(mesaj),
        ),
        body: buildBody(context));
  }

  void mesajGoster(String durum, BuildContext context) {
    var alert = AlertDialog(
      title: Text("Sınav Sonucu"),
      content: Text(durum),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: ogrenciler.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${ogrenciler[index].iurl}"),
                  ),
                  title: Text(
                      ogrenciler[index].ad + " " + ogrenciler[index].soyad),
                  subtitle: Text("Sınavdan aldığı not:" +
                      " " +
                      ogrenciler[index].not.toString() +
                      " " +
                      ogrenciler[index].getDurum),
                  trailing: iconOlustur(ogrenciler[index].not),
                  onTap: () {
                    setState(() {
                      selectedStudent = ogrenciler[index];
                    });
                    print(selectedStudent.ad +" "+ selectedStudent.soyad);
                  },
                );
              }),
        ),
        Text("Seçli öğrenci: " + selectedStudent.ad +" "+selectedStudent.soyad),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5.0,),
                    Text("Yeni Öğrenci"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context , MaterialPageRoute(builder: (context)=>OgrenciAdd(ogrenciler)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.indigo,
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 5.0,),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context , MaterialPageRoute(builder: (context)=>OgrenciUpdate(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.redAccent,
                child: Row(
                  children: [
                    Icon(Icons.delete_forever_outlined),
                    SizedBox(width: 5.0,),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    ogrenciler.remove(selectedStudent);
                  });
                  String durum = "Silindi";
                  mesajGoster(durum, context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget iconOlustur(int not) {
    if (not < 60) {
      return Icon(Icons.cancel);
    } else if (not >= 60) {
      return Icon(Icons.done);
    }
  }
}
