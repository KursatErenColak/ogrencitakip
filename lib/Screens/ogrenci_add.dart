import 'package:flutter/material.dart';
import 'package:flutter_app/Models/ogrencimodel.dart';
import 'package:flutter_app/validations/ogrenci_validator.dart';

class OgrenciAdd extends StatefulWidget {
  List<Ogrenci> ogrenciler;
  OgrenciAdd(List<Ogrenci> ogrenci){
    this.ogrenciler=ogrenci;
  }
  @override
  State<StatefulWidget> createState() {
    return _OgrenciAddState(ogrenciler);
  }
}

class _OgrenciAddState extends State with OgrenciValidationMixin {
  List<Ogrenci> ogrenciler;
  var ogrenci = Ogrenci.withoutInfo();
  var formkey = GlobalKey<FormState>();

  _OgrenciAddState(List<Ogrenci> ogrenci){
    this.ogrenciler=ogrenci;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni öğrenci ekle"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              buildAdField(),
              buildSoyadField(),
              buildNotField(),
              buildLinkField(),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAdField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci Adı:", hintText: "Kursat"),
      validator: validatead,
      onSaved: (String value) {
        ogrenci.ad = value;
      },
    );
  }

  Widget buildSoyadField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı:", hintText: "Colak"),
      validator: validatesoyad,
      onSaved: (String value) {
        ogrenci.soyad = value;
      },
    );
  }

  Widget buildNotField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Notu:", hintText: "99"),
      validator: validatenot,
      onSaved: (String value) {
        ogrenci.not = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        if (formkey.currentState.validate()) {
          formkey.currentState.save();
          ogrenciler.add(ogrenci);
          saveOgrenci();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveOgrenci() {
    print(ogrenci.ad);
    print(ogrenci.soyad);
    print(ogrenci.not);
  }

 Widget buildLinkField() {
    return TextFormField(
      decoration:
      InputDecoration(labelText: "Öğrenci Resim Linki:", hintText: "https://cdn.pixabay.com/photo..."),
      validator: validatelink,
      onSaved: (String value) {
        ogrenci.iurl = value;
      },
    );
  }
}
