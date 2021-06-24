import 'package:http/http.dart' as http;

class ImagesApi{
  static Future getStudents(){
    return http.get(Uri.http('10.0.2.2:3000', '/students'));
  }
}