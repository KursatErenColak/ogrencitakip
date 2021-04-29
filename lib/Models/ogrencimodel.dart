import 'package:flutter/cupertino.dart';

class Ogrenci{
  int id;
  String ad;
  String soyad;
  int not;
  String _durum="";
  String iurl;
  Ogrenci.withId(int id,String ad , String soyad , int not , String iurl  ){
    this.id = id;
    this.ad=ad;
    this.soyad = soyad;
    this.not=not;
    this._durum="";
    this.iurl = iurl;
  }
  Ogrenci(String ad , String soyad , int not , String iurl  ){
    this.ad=ad;
    this.soyad = soyad;
    this.not=not;
    this._durum="";
    this.iurl = iurl;
  }
  Ogrenci.withoutInfo(){

  }
  String get getDurum{
    String mesaj = "";
    if (this.not < 60) {
      mesaj="Kaldı";
    } else if (this.not >= 60) {
      mesaj="Geçti";
    }
    return mesaj;
  }
}