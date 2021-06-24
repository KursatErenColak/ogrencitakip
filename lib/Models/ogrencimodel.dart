class Ogrenci {
  int id;
  String ad;
  String soyad;
  int not;
  String durum = "";
  String iurl;

  Ogrenci(this.id, this.ad, this.soyad, this.not, this.durum, this.iurl);

  Ogrenci.fromJson(Map json) {
    id = json["id"];
    ad = json["ad"];
    soyad = json["soyad"];
    not = json["not"];
    durum = json["_durum"];
    iurl = json["url"];
  }
  Map toJson() {
    return {
      "id": id,
      "ad": ad,
      "soyad": soyad,
      "not": not,
      "_durum": durum,
      "url": iurl
    };
  }

  Ogrenci.withId(int id, String ad, String soyad, int not, String iurl) {
    this.id = id;
    this.ad = ad;
    this.soyad = soyad;
    this.not = not;
    this.durum = "";
    this.iurl = iurl;
  }
  Ogrenci.withoutInfo() {}

  String get getDurum {
    String mesaj = "";
    if (this.not < 60) {
      mesaj = "Kaldı";
      this.durum="Kaldı";
    } else if (this.not >= 60) {
      mesaj = "Geçti";
      this.durum="Geçti";
    }
    return mesaj;
  }
}
