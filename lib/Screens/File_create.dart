import 'package:flutter/material.dart';
import 'package:flutter_app/File_Process/Text_file.dart';

class FileCreateScreen extends StatefulWidget{
  FileCreateScreen():super();
  final String title = "Dosya İslemleri";
  @override
  _FileCreateScreenState createState()=>
      _FileCreateScreenState();
  }

class _FileCreateScreenState extends State<FileCreateScreen>{
  String metin = "Veri Yok";
  final yazialani = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: yazialani,
            ),
          ),
          ElevatedButton(
            child: Text("Dosyaya Yaz"),
            onPressed: (){
              FileProcess.savetoFile(yazialani.text);
            },
          ),
          ElevatedButton(
            child: Text("Dosyayı Oku"),
            onPressed: (){
              FileProcess.readFromFile().then((contents) {
                setState(() {
                  metin = contents;
                });
              });
            },
          ),
          Text(metin),
        ],
      ),
    );
    throw UnimplementedError();
  }
}
