class OgrenciValidationMixin{
  String validatead(String value){
    if(value.length<2){
      return "İsim en az 2 karakterden oluşmalıdır";
    }
  }
  String validatesoyad(String value){
    if(value.length<2){
      return "Soyisim en az 2 karakterden oluşmalıdır";
    }
  }
  String validatenot(String value){
    String controlMessage = "";
    var not = int.parse(value);
    if(not<0 || not>100){
      controlMessage = "Lütfen 0'dan büyük veya 100'den küçük bir karakter giriniz!";
      return controlMessage;
    }
  }
  String validatelink(String value){
    if(value.length<12){
      return "Lİnk en az 12 karakterden oluşmalıdır";
    }
    else if (value.matchAsPrefix("https://cdn.pixabay.com/",0)==false){
      return"Link hatalı!";
    }
  }
}