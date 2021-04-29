import 'package:flutter/material.dart';
import 'package:flutter_app/Models/ogrencimodel.dart';
import 'package:flutter_app/validations/ogrenci_validator.dart';

class OgrenciUpdate extends StatefulWidget {
  Ogrenci seciliogrenci;
  OgrenciUpdate( Ogrenci seciliogrenci){
    this.seciliogrenci=seciliogrenci;
  }
  @override
  State<StatefulWidget> createState() {
    return _OgrenciUpdateState(seciliogrenci);
  }
}

class _OgrenciUpdateState extends State with OgrenciValidationMixin {
  Ogrenci seciliogrenci;

  var formkey = GlobalKey<FormState>();

  _OgrenciUpdateState(Ogrenci seciliogrenci){
    this.seciliogrenci=seciliogrenci;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Öğrenciyi Düzenle"),
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
      initialValue: seciliogrenci.ad,
      decoration:
      InputDecoration(labelText: "Öğrenci Adı:", hintText: "Kursat"),
      validator: validatead,
      onSaved: (String value) {
        seciliogrenci.ad = value;
      },
    );
  }

  Widget buildSoyadField() {
    return TextFormField(
      initialValue: seciliogrenci.soyad,
      decoration:
      InputDecoration(labelText: "Öğrenci Soyadı:", hintText: "Colak"),
      validator: validatesoyad,
      onSaved: (String value) {
        seciliogrenci.soyad = value;
      },
    );
  }

  Widget buildNotField() {
    return TextFormField(
      initialValue: seciliogrenci.not.toString(),
      decoration: InputDecoration(labelText: "Öğrenci Notu:", hintText: "99"),
      validator: validatenot,
      onSaved: (String value) {
        seciliogrenci.not = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      textColor: Colors.limeAccent,
      color: Colors.black,
      child: Text("Kaydet"),
      onPressed: () {
        if (formkey.currentState.validate()) {
          formkey.currentState.save();
          saveOgrenci();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveOgrenci() {
    print(seciliogrenci.ad);
    print(seciliogrenci.soyad);
    print(seciliogrenci.not);
    print(seciliogrenci.iurl);
  }

  Widget buildLinkField() {
    return TextFormField(
      initialValue: seciliogrenci.iurl,
      decoration:
      InputDecoration(labelText: "Öğrenci Resim Linki:", hintText: "https://cdn.pixabay.com/photo..."),
      validator: validatelink,
      onSaved: (String value) {
        seciliogrenci.iurl = value;
      },
    );
  }
}
