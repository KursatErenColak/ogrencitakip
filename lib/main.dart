import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/Images_api/ogrenci_images.dart';
import 'package:flutter_app/Models/ogrencimodel.dart';
import 'package:flutter_app/Screens/ogrenci_add.dart';
import 'package:path_provider/path_provider.dart';
import 'Screens/ogrenci_chart.dart';
import 'Screens/File_create.dart';
import 'Screens/ogrenci_update.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "Öğrenci Takip Uygulaması";

  Ogrenci selectedStudent = Ogrenci.withId(0, "", "", 0, "");

  List<Ogrenci> ogrenciler = List<Ogrenci>();

  @override
  void initState() {
    getOgrenciFromApi();
    super.initState();
  }
  /*[
    new Ogrenci.withId(1, "Kursat", "Colak", 55,
        "https://cdn.pixabay.com/photo/2018/01/17/07/06/laptop-3087585__340.jpg"),
    Ogrenci.withId(2, "Eren", "Colak", 75,
        "https://cdn.pixabay.com/photo/2018/09/11/19/49/education-3670453__340.jpg")
  ];*/

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
                      ogrenciler[index].durum),
                  trailing: iconOlustur(ogrenciler[index].not),
                  onTap: () {
                    setState(() {
                      selectedStudent = ogrenciler[index];
                    });
                    print(selectedStudent.ad +" "+ selectedStudent.soyad);
                  },
                  onLongPress: () =>{
                  Navigator.push(context , MaterialPageRoute(builder: (context)=>OgrenciUpdate(selectedStudent)))
                  },
                );
              }),
        ),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.teal
            ),
            child: Row(
              children: [
                Icon(Icons.add_box_outlined),
                SizedBox(width: 1.0,),
                Text("Not Dosyası oluştur"),
              ],
            ),
            onPressed: () {
              Navigator.push(context , MaterialPageRoute(builder: (context)=>FileCreateScreen()));
            },

          ),
        ),
        InteractiveViewer(
          scaleEnabled: true,
          panEnabled: true,
          boundaryMargin: EdgeInsets.all(80),
          minScale: 0.5,
          maxScale: 4,
          child: FlutterLogo(size: 100),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.lightGreenAccent,
            child: new GestureDetector(
              child: new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      SizedBox(width: 1.0,),
                      Text("Geliştirici bilgileri için çift tıklayınız!"),
                    ],
                  ),
              ),
              onDoubleTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  new SnackBar(content: new Text('Geliştirici adı : Kürşat Eren Çolak Geliştirilme yılı : 2021 Referans Akademisyen: 	Dr. Öğr. Üyesi Ahmet Cevahir ÇINAR'))
                );
              },
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.deepOrangeAccent
            ),
            child: Row(
              children: [
                Icon(Icons.bar_chart),
                SizedBox(width: 1.0,),
                Text("Grafik Yüzdesi"),
              ],
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PieChartSample1(ogrenciler)));
            },
          ),
        ),
        Text("Seçli öğrenci: " + selectedStudent.ad +" "+selectedStudent.soyad),
        Row(
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
                child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey
                ),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 1.0,),
                    Text("Ekle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context , MaterialPageRoute(builder: (context)=>OgrenciAdd(ogrenciler)));
                },
                
              ),
              ),
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
                child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent

                ),
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 1.0,),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context , MaterialPageRoute(builder: (context)=>OgrenciUpdate(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
                child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent
                ),
                child: Row(
                  children: [
                    Icon(Icons.delete_forever_outlined),
                    SizedBox(width: 1.0,),
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
    }
    else if (not >= 60) {
      return Icon(Icons.done);
    }
  }

  void getOgrenciFromApi() {
    ImagesApi.getStudents().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        this.ogrenciler = list.map((ogrenci) => Ogrenci.fromJson(ogrenci)).toList();
      });
    });
  }
}
